import { NextResponse, NextRequest } from "next/server";
import { poolUser } from "@/config/db";

export async function GET(response: NextResponse) {
    try {
        const result = await poolUser.query("SELECT id_usr, nombres, apellidos, nacionalidad, direccion FROM usuario");
        return NextResponse.json(result);
    } catch (error) {
        console.error('Error executing query: ', error);
        return NextResponse.json({ error: 'Internal Server ERRRROR' }, { status: 500 });
    }
}

export async function POST(request: NextRequest) {
    const { name, last_name, nation } = await request.json();

    try {
        const result = await poolUser.query('INSERT INTO usuario (nombres, apellidos, nacionalidad, id_admin) VALUES ($1, $2, $3, 3) RETURNING id_usr', 
        [name, last_name, nation]);
        return NextResponse.json({
            name,
            last_name,
            nation,
            id: result.rows[0].id_usr,
        });
    } catch (error) {
        console.error('Error executing query: ', error);
        return NextResponse.json({ error: 'Internal Server ERRRROR' }, { status: 500 });
    }
}

