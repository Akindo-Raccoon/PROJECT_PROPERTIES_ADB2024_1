'use client'

import React from "react";
import { useRef, useState } from "react";
import axios from "axios";
import { useRouter } from "next/navigation";
import { Input } from "@nextui-org/react";
import { EyeSlashFilledIcon } from "./atomic/EyeSlashFilledIcon";
import { EyeFilledIcon } from "./atomic/EyeFilledIcon";

//const axios = require('axios');

function FormLogin() {
    const [user, setUser] = useState({
        name: "",
        last_name: "",
        nation: "",
        address: ""
    });

    const [isVisible, setIsVisible] = React.useState(false);

    const toggleVisibility = () => setIsVisible(!isVisible);

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
        <form className="bg-lime-200 shadow-md rounded-md px-8 pt-6 pb-8 mb-4" onSubmit={handleSubmit} ref={form}>
            <label htmlFor="name" className="block text-gray-700 text-sm font-bold mb-2"> Nickname</label>
            <Input label="Admin User" name="name_adm" type="text" placeholder="Enter your Admin User" onChange={handleChange}
                className="max-w-xs" variant="bordered" isRequired />
            <br />
            <label htmlFor="last_name" className="block text-gray-700 text-sm font-bold mb-2"> Password</label>
            <Input onChange={handleChange} isRequired
                label="Password"
                variant="bordered"
                placeholder="Enter your password"
                endContent={
                    <button className="focus:outline-none" type="button" onClick={toggleVisibility}>
                        {isVisible ? (
                            <EyeSlashFilledIcon className="text-2xl text-default-400 pointer-events-none" />
                        ) : (
                            <EyeFilledIcon className="text-2xl text-default-400 pointer-events-none" />
                        )}
                    </button>
                }
                type={isVisible ? "text" : "password"}
                className="max-w-xs" />
            <br />
        </form>
    )
}

export default FormLogin;