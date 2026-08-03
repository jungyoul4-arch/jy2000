import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

async function checkTables() {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '3306'),
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'jysk',
  });

  try {
    const [tables] = await connection.query('SHOW TABLES LIKE "schedule%"');
    console.log('Tables starting with "schedule":', tables);
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await connection.end();
  }
}

checkTables();
