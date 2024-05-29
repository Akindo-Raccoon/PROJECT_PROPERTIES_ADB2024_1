import { NextRequest, NextResponse } from "next/server";
import { poolAdmin, poolUser } from "@/config/db";

export async function GET(request: NextRequest, { params }: any) {
    try {
        const result = await poolAdmin.query('SELECT id_admin FROM admin WHERE (name = $1)', [params.name]);
        if (result.length === 0) {
            return NextResponse.json({
                message: 'Producto no encontrado',

            }, {
                status: 404
            })
        }
        return NextResponse.json(result.rows[0]);
    } catch (error) {
        console.error('Error executing query: ', error);
        return NextResponse.json({ error: 'Internal Server ERRRROR' }, { status: 404 });
    }
}

export async function DELETE(request: NextRequest, { params }: any) {
    try {
        const result = await poolAdmin.query('DELETE FROM usuario WHERE (id_admin = $1)', [params.id]);
        console.log(result);
        if (result.rowCount === 0) {
            return NextResponse.json({
                message: 'Producto no encontrado',

            }, {
                status: 404
            })
        }
        return new Response(null, {
            status: 204,
        })
    } catch (error) {
        console.error('Error executing query: ', error);
        return NextResponse.json({ error: 'Internal Server ERRRROR' }, { status: 500 });
    }
}

export async function PUT(request: NextRequest, { params }: any) {
    try {
        const data = await request.json();
        const { name, last_name, nation, address } = data;
        const result = await poolAdmin.query('UPDATE usuario SET nombres = $1, apellidos = $2, nacionalidad = $3, direccion = $4 WHERE (id_usr = $5)',
            [name, last_name, nation, address, params.id])
        console.log(result);
        if (result.rowCount === 0) {
            return NextResponse.json({
                message: 'Usuario no encontrado',
            }, {
                status: 404
            });
        }

        const updateUser = await poolAdmin.query('SELECT * FROM admin WHERE (id_admin = $1)', [params.id]);
        console.log(updateUser);
        return NextResponse.json(updateUser.rows[0]);
    } catch (error) {
        console.error('Error executing query: ', error);
        return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
    }
}


