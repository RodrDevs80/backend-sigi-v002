import { z } from 'zod';

export const CreateCorrelatividadDto = z.object({
  idPlan: z.number().int().positive().optional(),
  idAsignatura: z.number().int().positive().optional(),
  idAsignaturaCorrelativa: z.number().int().positive().optional(),
  condicion: z
    .enum(['REGULARIZADA', 'APROBADA', 'PENDIENTE', 'DESAPROBADA'])
    .optional().default('PENDIENTE'),
});
export type CreateCorrelatividadDto = z.infer<typeof CreateCorrelatividadDto>;
