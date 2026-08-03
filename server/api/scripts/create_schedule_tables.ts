import mysql from 'mysql2/promise';
import * as fs from 'fs';
import * as path from 'path';
import dotenv from 'dotenv';

dotenv.config();

async function createTables() {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '3306'),
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'jysk',
    multipleStatements: true,
  });

  try {
    const sqlPath = path.join(__dirname, '../../database/schedule.sql');
    const sql = fs.readFileSync(sqlPath, 'utf8');

    console.log('Creating schedule tables from schedule.sql...');
    await connection.query(sql);
    console.log('Schedule tables created successfully!');
  } catch (error) {
    console.error('Failed to create tables:', error);
    throw error;
  } finally{
    await connection.end();
  }
}

createTables();
