/**
 * class_type 테이블 재생성 스크립트
 * 실행: npx ts-node scripts/recreateClassTypeTables.ts
 */

import * as dotenv from 'dotenv';
import * as path from 'path';

dotenv.config({ path: path.join(__dirname, '..', '.env') });

import pool from '../src/config/database';

async function main() {
  console.log('class_type 테이블 재생성 시작...');

  try {
    // FK 체크 비활성화
    await pool.query('SET FOREIGN_KEY_CHECKS = 0');

    // 기존 테이블 삭제
    await pool.query('DROP TABLE IF EXISTS class_type_teacher');
    await pool.query('DROP TABLE IF EXISTS class_type');

    // class_type 테이블 생성
    await pool.query(`
      CREATE TABLE class_type (
        class_type_id       INT AUTO_INCREMENT COMMENT '반형태 ID',
        class_type_name     VARCHAR(100) NOT NULL COMMENT '반형태명',
        grade               INT NOT NULL COMMENT '학년 (1~6:초1~초6, 7~9:중1~중3, 10~12:고1~고3)',
        subject             INT NOT NULL COMMENT '과목 (1=국어, 2=수학, 3=영어, 4=과학, 5=사회)',
        unit_price          INT DEFAULT 0 COMMENT '단가 (원)',
        is_active           TINYINT(1) DEFAULT 1 COMMENT '활성화 여부',
        created_at          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
        updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
        deleted_at          DATETIME NULL COMMENT '삭제일시 (soft delete)',
        PRIMARY KEY (class_type_id),
        UNIQUE INDEX idx_class_type_unique (class_type_name, grade, subject),
        INDEX idx_grade (grade),
        INDEX idx_subject (subject),
        INDEX idx_is_active (is_active),
        INDEX idx_deleted_at (deleted_at)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='반 형태'
    `);

    // class_type_teacher 테이블 생성
    await pool.query(`
      CREATE TABLE class_type_teacher (
        id                  INT AUTO_INCREMENT COMMENT 'ID',
        class_type_id       INT NOT NULL COMMENT '반형태 ID (FK: class_type)',
        teacher_id          INT NOT NULL COMMENT '강사 ID (FK: User.user_id)',
        created_at          DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
        PRIMARY KEY (id),
        INDEX idx_class_type_id (class_type_id),
        INDEX idx_teacher_id (teacher_id),
        CONSTRAINT fk_ctt_class_type FOREIGN KEY (class_type_id) REFERENCES class_type(class_type_id) ON DELETE CASCADE,
        CONSTRAINT fk_ctt_teacher FOREIGN KEY (teacher_id) REFERENCES User(user_id) ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='반 형태 - 강사 연결'
    `);

    // FK 체크 다시 활성화
    await pool.query('SET FOREIGN_KEY_CHECKS = 1');

    console.log('✅ 테이블 재생성 완료!');
    process.exit(0);
  } catch (error) {
    console.error('❌ 테이블 재생성 실패:', error);
    process.exit(1);
  }
}

main();
