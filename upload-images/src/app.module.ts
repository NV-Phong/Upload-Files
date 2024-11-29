import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MongooseModule } from '@nestjs/mongoose';
import { FileEntity, FileSchema } from './schema/file.schema';
import { ServeStaticModule } from '@nestjs/serve-static';
const path = require('path');

@Module({
  imports: [
    MongooseModule.forRoot('mongodb://localhost:27017/Upload-Images'),
    MongooseModule.forFeature([{ name: FileEntity.name, schema: FileSchema }]),
    ServeStaticModule.forRoot({
      rootPath: path.join(__dirname, '..', 'repository'),
      serveRoot: '/repository',
    }),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
