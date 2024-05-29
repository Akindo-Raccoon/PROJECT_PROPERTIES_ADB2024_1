

import axios from "axios";
import { Card, CardBody, Image, Button, Slider } from "@nextui-org/react";
import React from "react";

async function loadProperties(propertyId: any) {
    const {data} = await axios.get("http://localhost:3000/api/properties/" + propertyId);
    return data;
}


async function PropertyPage({params}:any) {
    const propertyArray = await loadProperties(params.id);
    const property = propertyArray.rows[0]

    return (
        <div className="text-red">
            <Card
      isBlurred
      className="border-none bg-background/60 dark:bg-default-100/50 max-w-[610px]"
      shadow="sm"
    >
      <CardBody>
        <div className="grid grid-cols-6 md:grid-cols-12 gap-6 md:gap-4 items-center justify-center">
          <div className="relative col-span-6 md:col-span-4">
            <Image
              alt="Property image"
              className="object-cover"
              height={200}
              shadow="md"
              src="https://via.placeholder.com/300" // Reemplaza esto con la URL de la imagen de la propiedad
              width="100%"
            />
          </div>

          <div className="flex flex-col col-span-6 md:col-span-8">
            <div className="flex justify-between items-start">
              <div className="flex flex-col gap-0">
                <h3 className="font-semibold text-foreground/90">Property Page</h3>
                <p className="text-small text-foreground/80">ID: {property.id_prp}</p>
                <h1 className="text-large font-medium mt-2">{property.tipo}</h1>
              </div>
              
            </div>

            <div className="flex flex-col mt-3 gap-1">
              <p className="text-small">Capacidad: {property.capacidad}</p>
              <p className="text-small">Numero de Banios: {property.nbanios}</p>
              <p className="text-small">Numero de habitaciones: {property.nhab}</p>
              <p className="text-small">
                Aire Acondicionado: {property.aire_ac ? "Sí" : "No"}
              </p>
              <p className="text-small">
                Calefaccion: {property.calefaccion ? "Sí" : "No"}
              </p>
              <p className="text-small">
                Permite mascotas?: {property.perm_mascts ? "Sí" : "No"}
              </p>
              <p className="text-small">ID region: {property.id_region}</p>
            </div>
          </div>
        </div>
      </CardBody>
    </Card>
        </div>

    )
};

export default PropertyPage;