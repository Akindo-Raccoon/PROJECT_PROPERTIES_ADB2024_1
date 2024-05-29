'use client'

import { useRef, useState } from "react";
import axios from "axios";
import { useRouter } from "next/navigation";

//const axios = require('axios');

function FormUser() {
    const [user, setUser] = useState({
        name: "",
        last_name: "",
        nation: "",
        address: ""
    });

    const form = useRef(null);
    const router = useRouter();

    const handleChange = (e: any) => {
        setUser({
            ...user,
            [e.target.name]: e.target.value
        })
    }

    const handleSubmit = async (e: any) => {
        e.preventDefault();
        const result = await axios.post('/api/users', user);
        console.log(result);
        form.current.reset();
        router.push('/properties');
    }

    return (
        <form className="bg-blue shadow-md rounded-md px-8 pt-6 pb-8 mb-4" onSubmit={handleSubmit} ref={form}>
            <label htmlFor="name" className="block text-gray-700 text-sm font-bold mb-2"> User Name</label>
            <input name="name" type="text" placeholder="name" onChange={handleChange} className="shadow appeareance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight" />
            <br />
            <label htmlFor="last_name" className="block text-gray-700 text-sm font-bold mb-2"> User Last Name</label>
            <input name="last_name" type="text" placeholder="Last Name" onChange={handleChange} className="shadow appeareance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight" />
            <br />
            <label htmlFor="nation" className="block text-gray-700 text-sm font-bold mb-2"> Users Nation</label>
            <input name="nation" type="text" placeholder="Nation" onChange={handleChange} className="shadow appeareance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight" />
            <br />
            <label htmlFor="address" className="block text-gray-700 text-sm font-bold mb-2"> Users Address</label>
            <textarea name="address" rows={3} placeholder="Address" onChange={handleChange} className="shadow appeareance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight" />
            <button className="bg-blue-300 hover:bg-blue-700 text-white font-blod py-2 px-4 rounded">
                Save User
            </button>

        </form>
    )
}

export default FormUser;