import {
  Injectable,
  BadRequestException,
  UnauthorizedException,
} from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { JwtService } from '@nestjs/jwt';
import { CreateUserDto } from '../users/dto/createUserDto';
import * as bcrypt from 'bcrypt';
import { HealthRecord } from '../health-records/schemas/healthRecord.schema';
import { User } from '../users/schemas/user.schema';
import { UpdateUserDto } from '../users/dto/updateUserDto';
import { HealthRecordsService } from '../health-records/health-records.service';
import { jwtConstants } from './constants';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
    private healthRecordsService: HealthRecordsService,
  ) {}

  async signUp(createUserDto: CreateUserDto): Promise<{ token: string }> {
    const { name, email, password } = createUserDto;

    const existingUser = await this.usersService.findOne(email);
    if (existingUser) {
      throw new BadRequestException('Email already exists');
    }

    if (!this.isValidEmail(email)) {
      throw new BadRequestException('Invalid email format');
    }

    if (!this.isValidPassword(password)) {
      throw new BadRequestException('Invalid password');
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const userr = await this.usersService.create({
      ...createUserDto,
      password: hashedPassword,
    });
    const token = this.jwtService.sign({
      id: userr.id,
      roles: userr.roles,
    });
    return { token };
  }

  async signIn(email: string, password: string): Promise<{ token: string }> {
    const userr = await this.usersService.findOne(email);
    if (!userr || !(await bcrypt.compare(password, userr.password))) {
      throw new UnauthorizedException('Invalid email or password');
    }
    const token = this.jwtService.sign({
      id: userr.id,
      roles: userr.roles,
    });
    return { token };
  }

  async deleteUser(id: string): Promise<void> {
    await this.usersService.deleteUser(id);
  }

  async deleteAllUsers(): Promise<void> {
    await this.usersService.deleteAll();
  }

  async updateUser(id: string, updateUserDto: UpdateUserDto): Promise<User> {
    return this.usersService.updateUser(id, updateUserDto);
  }

  async getHealthRecordsByUserId(request: Request): Promise<HealthRecord[]> {
    return this.usersService.getRecordsByUserId(request);
  }

  async extractTokenDetails(
    token: string,
  ): Promise<{ id: string; roles: string[] }> {
    const decoded = this.jwtService.decode(token) as {
      id: string;
      roles: string[];
    };
    return {
      id: decoded.id,
      roles: decoded.roles,
    };
  }

  private isValidEmail(email: string): boolean {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }

  private isValidPassword(password: string): boolean {
    return password.length >= 8;
  }

  async findAll() {
    return this.usersService.findAll();
  }

  async createAdmin(createUserDto: CreateUserDto): Promise<{ token: string }> {
    const { email, password } = createUserDto;

    const existingUser = await this.usersService.findOne(email);
    if (existingUser) {
      throw new BadRequestException('Email already exists');
    }

    if (!this.isValidEmail(email)) {
      throw new BadRequestException('Invalid email format');
    }

    if (!this.isValidPassword(password)) {
      throw new BadRequestException('Invalid password');
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const userr = await this.usersService.createAdmin({
      ...createUserDto,
      password: hashedPassword,
    });
    const token = this.jwtService.sign({
      id: userr.id,
      roles: userr.roles,
    });
    return { token };
  }

  async createInitialAdmin(
    createUserDto: CreateUserDto,
  ): Promise<{ token: string }> {
    const existingAdmins = await this.usersService.findAdmins();
    if (existingAdmins.length > 0) {
      throw new BadRequestException('Admin user already exists');
    }

    if (!this.isValidEmail(createUserDto.email)) {
      throw new BadRequestException('Invalid email format');
    }

    if (!this.isValidPassword(createUserDto.password)) {
      throw new BadRequestException('Invalid password');
    }

    const hashedPassword = await bcrypt.hash(createUserDto.password, 10);
    const userr = await this.usersService.createAdmin({
      ...createUserDto,
      password: hashedPassword,
    });
    const token = this.jwtService.sign({
      id: userr.id,
      roles: userr.roles,
    });
    return { token };
  }

  async changePassword(
    userId: string,
    changePasswordDto: { currentPassword: string; newPassword: string },
  ): Promise<void> {
    const { currentPassword, newPassword } = changePasswordDto;
    const user = await this.usersService.findById(userId);

    if (!user || !(await bcrypt.compare(currentPassword, user.password))) {
      throw new UnauthorizedException('Current password is incorrect');
    }

    if (!this.isValidPassword(newPassword)) {
      throw new BadRequestException('Invalid new password');
    }

    user.password = await bcrypt.hash(newPassword, 10);
    await this.usersService.updateUser(userId, user);
  }
  async validatePassword(
    plainPassword: string,
    hashedPassword: string,
  ): Promise<boolean> {
    return bcrypt.compare(plainPassword, hashedPassword);
  }

  async deleteAccount(request: Request, password: string): Promise<void> {
    const token = this.extractTokenFromRequest(request);
    const userId = this.extractUserIdFromToken(token);

    const user = await this.usersService.findById(userId);
    if (!user) {
      throw new BadRequestException('User not found');
    }
    if (!(await this.validatePassword(password, user.password))) {
      throw new UnauthorizedException('Invalid password');
    }
    await this.usersService.deleteUser(userId);
  }

  private extractTokenFromRequest(request: Request): string | undefined {
    const authorizationHeader = request.headers['authorization'];
    if (authorizationHeader && authorizationHeader.startsWith('Bearer ')) {
      return authorizationHeader.substring('Bearer '.length);
    }
    return undefined;
  }

  private extractUserIdFromToken(token: string): string | undefined {
    try {
      const decodedToken = this.jwtService.verify(token, {
        secret: jwtConstants.secret,
      }) as {
        sub: string;
      };
      return decodedToken.sub;
    } catch (error) {
      throw new UnauthorizedException('Invalid token');
    }
  }
}
