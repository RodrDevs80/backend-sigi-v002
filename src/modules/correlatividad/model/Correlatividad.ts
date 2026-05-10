import {
  Model,
  DataTypes,
  InferAttributes,
  InferCreationAttributes,
  CreationOptional,
  ForeignKey,
} from 'sequelize';
import sequelize from '../../../config/database/conexion.js';

interface CorrelatividadAttributes extends InferAttributes<Correlatividad> {
  id: number;
  idPlan: number;
  idAsignatura: number;
  idAsignaturaCorrelativa: number;
  condicion: 'REGULARIZADA' | 'APROBADA' | 'PENDIENTE' | 'DESAPROBADA';
}

interface CorrelatividadCreationAttributes
  extends InferCreationAttributes<Correlatividad> {
  idPlan: number;
  idAsignatura: number;
  idAsignaturaCorrelativa: number;
  condicion: 'REGULARIZADA' | 'APROBADA' | 'PENDIENTE' | 'DESAPROBADA';
}

class Correlatividad extends Model<
  CorrelatividadAttributes,
  CorrelatividadCreationAttributes
> {
  declare id: CreationOptional<number>;
  declare idPlan: ForeignKey<number>;
  declare idAsignatura: ForeignKey<number>;
  declare idAsignaturaCorrelativa: ForeignKey<number>;
  declare condicion: 'REGULARIZADA' | 'APROBADA' | 'PENDIENTE' | 'DESAPROBADA';
}

Correlatividad.init(
  {
    id: {
      type: DataTypes.INTEGER.UNSIGNED,
      autoIncrement: true,
      primaryKey: true,
    },
    idPlan: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      field: 'id_plan',
      references: {
        model: 'planes',
        key: 'id',
      },
    },
    idAsignatura: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      field: 'id_asignatura',
      references: {
        model: 'asignaturas',
        key: 'id',
      },
    },
    idAsignaturaCorrelativa: {
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      field: 'id_asignatura_correlativa',
      references: {
        model: 'asignaturas',
        key: 'id',
      },
    },
    condicion: {
      type: DataTypes.ENUM('REGULARIZADA', 'APROBADA', 'PENDIENTE', 'DESAPROBADA'),
      allowNull: false,
      defaultValue: 'PENDIENTE',
    },
  },
  {
    sequelize,
    tableName: 'correlatividades',
    timestamps: true,
  }
);

export default Correlatividad;
