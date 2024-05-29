import { NextResponse } from "next/server";
import { poolUser } from "@/config/db";

export async function GET(response: NextResponse) {
    try {
        const data = await poolUser.query('SELECT id_prp, tipo, capacidad, nbanios, nhab, aire_ac, calefaccion, perm_mascts FROM propiedad WHERE id_usr=78');
        return NextResponse.json(data);
    } catch (error) {
        console.error('Error executing query: ', error);
        return NextResponse.json({ error: 'Internal Server ERRRROR' }, { status: 500 });
    }
};
