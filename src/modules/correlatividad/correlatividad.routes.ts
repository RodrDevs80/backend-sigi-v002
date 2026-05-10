import { Router } from 'express';
import { CorrelatividadController } from './controller/correlatividad.controller.js';
import { validateJwt } from '../../core/middlewares/validate-jwt.middleware.js';
import { Role } from '../../core/enums/role.enum.js';
import { validateRole } from '../../core/middlewares/validate-role.middleware.js';

const router = Router();

// Aplicar autenticación a todas las rutas
router.use(validateJwt);

// Lectura: cualquier usuario autenticado
router.get('/', CorrelatividadController.getAll);
router.get('/:id', CorrelatividadController.getById);

// Escritura: solo administradores
router.post('/', validateRole(Role.ADMIN), CorrelatividadController.create);
router.patch('/:id', validateRole(Role.ADMIN), CorrelatividadController.update);
router.delete('/:id', validateRole(Role.ADMIN), CorrelatividadController.delete);

export default router;
