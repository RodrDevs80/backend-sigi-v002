import { DataTypes, Model, InferAttributes, InferCreationAttributes, CreationOptional } from "sequelize";
import sequelize from "../../../config/database/conexion.js";

interface MesaExamenAttributes extends InferAttributes<MesaExamen> {
    id: number;
    IdTurnoExamen: number;
    IdUnidadCurricular: number;
    fecha: Date;
    hora: string;
    idDocentePresidente: number;
    idDocenteVocal1: number;
    idDocenteVocal2: number;
    totalInscripto: number;
    totalAprobados: number;
    totalDesaprobados: number;
    totalAusentes: number;
    tipo: string;
    activo: CreationOptional<boolean>;
    idAdministrativo: number;
}

interface MesaExamenCreationAttributes extends InferCreationAttributes<MesaExamen> {
    IdTurnoExamen: number;
    IdUnidadCurricular: number;
    fecha: Date;
    hora: string;
    idDocentePresidente: number;
    idDocenteVocal1: number;
    idDocenteVocal2: number;
    totalInscripto: number;
    totalAprobados: number;
    totalDesaprobados: number;
    totalAusentes: number;
    tipo: string;
    idAdministrativo: number;
}

class MesaExamen extends Model<MesaExamenAttributes, MesaExamenCreationAttributes> {
    declare id: CreationOptional<number>;
    declare IdTurnoExamen: number;
    declare IdUnidadCurricular: number;
    declare fecha: Date;
    declare hora: string;
    declare idDocentePresidente: number;
    declare idDocenteVocal1: number;
    declare idDocenteVocal2: number;
    declare totalInscripto: number;
    declare totalAprobados: number;
    declare totalDesaprobados: number;
    declare totalAusentes: number;
    declare tipo: string;
    declare activo: CreationOptional<boolean>;
    declare idAdministrativo: number;
}

MesaExamen.init(
    {
        id: {
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primaryKey: true,
        },
        IdTurnoExamen: {
            type: DataTypes.INTEGER,
            allowNull: false,
            field: "id_turno_examen",
            references: { model: "turnos_examenes", key: "id" },
        },
        IdUnidadCurricular: {
            type: DataTypes.INTEGER,
            allowNull: false,
            field: "id_unidad_curricular",
            references: { model: "unidades_curriculares", key: "id" },
        },
        fecha: {
            type: DataTypes.DATEONLY,
            allowNull: false,
        },
        hora: {
            type: DataTypes.STRING(10),
            allowNull: false,
        },
        idDocentePresidente: {
            type: DataTypes.INTEGER,
            allowNull: false,
            field: "id_docente_presidente",
            references: { model: "docentes", key: "id" },
        },
        idDocenteVocal1: {
            type: DataTypes.INTEGER,
            allowNull: false,
            field: "id_docente_vocal1",
            references: { model: "docentes", key: "id" },
        },
        idDocenteVocal2: {
            type: DataTypes.INTEGER,
            allowNull: false,
            field: "id_docente_vocal2",
            references: { model: "docentes", key: "id" },
        },
        totalInscripto: {
            type: DataTypes.INTEGER,
            defaultValue: 0,
            field: "total_inscripto",
        },
        totalAprobados: {
            type: DataTypes.INTEGER,
            defaultValue: 0,
            field: "total_aprobados",
        },
        totalDesaprobados: {
            type: DataTypes.INTEGER,
            defaultValue: 0,
            field: "total_desaprobados",
        },
        totalAusentes: {
            type: DataTypes.INTEGER,
            defaultValue: 0,
            field: "total_ausentes",
        },
        tipo: {
            type: DataTypes.ENUM("ORDINARIO", "EXTRAORDINARIO", "RECUPERACION"),
            allowNull: false,
        },
        activo: {
            type: DataTypes.BOOLEAN,
            defaultValue: true,
        },
        idAdministrativo: {
            type: DataTypes.INTEGER,
            allowNull: false,
            field: "id_administrativo",
            references: { model: "administrativos", key: "id" },
        },
    },
    {
        sequelize,
        tableName: "mesas_examenes",
        timestamps: true,
        // Opcional: índices para optimizar consultas
        indexes: [
            { fields: ["turno_examen_id"] },
            { fields: ["unidad_curricular_id"] },
            { fields: ["fecha"] },
            { fields: ["id_administrativo"] },
        ]
    }
);

export default MesaExamen;