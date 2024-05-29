import {Pool} from 'pg';

let poolAdmin: any;
let poolOwner: any;
let poolUser: any;

if (!poolAdmin) {
    poolAdmin = new Pool({
        host: "localhost",
        port: 5432,
        database: "feliz_sa",
        user: "admin_vf",
        password: "admin1234"
    });
}

if (!poolOwner) {
    poolOwner = new Pool({
        host: "localhost",
        port: 5432,
        database: "feliz_sa",
        user: "owner_vf",
        password: "owner1234"
    });
}

if (!poolUser) {
    poolUser = new Pool({
        host: "localhost",
        port: 5432,
        database: "feliz_sa",
        user: "user_vf",
        password: "user1234"
    });
}

export {poolAdmin, poolUser, poolOwner};
