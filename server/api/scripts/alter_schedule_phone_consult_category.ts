import mysql from 'mysql2/promise';
import * as fs from 'fs';
import * as path from 'path';
import dotenv from 'dotenv';

dotenv.config();

async function runMigration() {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '3306'),
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'jysk',
    multipleStatements: true,
  });

  try {
    const sqlPath = path.join(
      __dirname,
      '../../database/alter_schedule_phone_consult_category.sql'
    );
    const sql = fs.readFileSync(sqlPath, 'utf8');

    console.log('Running migration: alter_schedule_phone_consult_category.sql');
    await connection.query(sql);

    const [rows] = await connection.query(
      `SELECT category_id, category_name, category_type, sort_order
       FROM schedule_category
       WHERE deleted_at IS NULL
       ORDER BY sort_order ASC`
    );
    console.log('현재 카테고리 순서:');
    console.table(rows);

    console.log('Migration completed successfully!');
  } catch (error) {
    console.error('Migration failed:', error);
    throw error;
  } finally {
    await connection.end();
  }
}

runMigration();
