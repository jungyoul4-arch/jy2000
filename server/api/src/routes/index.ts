import { Router } from 'express';
import studentRoutes from './studentRoutes';
import consultRoutes from './consultRoutes';
import promotionRoutes from './promotionRoutes';
import tcRoutes from './tcRoutes';
import dashboardRoutes from './dashboardRoutes';
import codeRoutes from './codeRoutes';
import authRoutes from './authRoutes';
import schoolRoutes from './schoolRoutes';
import calendarRoutes from './calendarRoutes';

const router = Router();

// API Routes
router.use('/auth', authRoutes);
router.use('/student', studentRoutes);
router.use('/consult', consultRoutes);
router.use('/promotion', promotionRoutes);
router.use('/tc', tcRoutes);
router.use('/dashboard', dashboardRoutes);
router.use('/code', codeRoutes);
router.use('/school', schoolRoutes);
router.use('/calendar', calendarRoutes);

export default router;
