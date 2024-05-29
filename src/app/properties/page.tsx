'use client'

import { useEffect, useState } from 'react';
import PropertyCard from "@/components/PropertyCard";
import Navbar from "@/components/NavBar";
import axios from "axios";

function PropertiesPage() {
    const [properties, setProperties] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const loadProperties = async () => {
            try {
                const { data } = await axios.get("http://localhost:3000/api/properties");
                setProperties(data.rows);
            } catch (err: any) {
                setError(err);
            } finally {
                setLoading(false);
            }
        };

        loadProperties();
    }, []);

    if (loading) {
        return <p>Loading...</p>;
    }

    if (error) {
        return <p>Error loading properties: {error}</p>;
    }

    return (
        <>
            <Navbar />
            <div className="grid gap-4 grid-cols-4">
                {properties.map((property: any) => (
                    <PropertyCard property={property} key={property.id} />
                ))}
            </div>
        </>
    );
}

export default PropertiesPage;
