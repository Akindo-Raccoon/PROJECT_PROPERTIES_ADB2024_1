import { Card, CardBody, CardFooter, CardHeader, Image } from "@nextui-org/react";
import Link from "next/link";

function PropertyCard({ property, key }: any) {
    return (
        <Card isFooterBlurred
            key={key}
            radius="lg"
            className="border-none">

            <CardHeader>
                <Link className="bg-blue rounded-lg border-gray-800 mb-3 hover:bg-gray-100 hover:cursor-pointer"
                    href={'/properties/${properties.id}'} />
                    {property.tipo}
                
            </CardHeader>

            <CardBody>
                <Image
                    alt="Woman listing to music"
                    className="object-cover"
                    height={200}
                    src="https://tipsparatuviaje.com/wp-content/uploads/2018/11/tahiti-francia.jpg"
                    width={200}
                />
            </CardBody>
            <CardFooter className="justify-between before:bg-white/10 border-white/20 border-1 overflow-hidden py-1 absolute before:rounded-xl rounded-large bottom-1 w-[calc(100%_-_8px)] shadow-small ml-1 z-10">
                <h1 className="text-lg font-bold">{property.tipo}</h1>
                <h2 className="text-2xl text-slate-600">{property.capacidad}</h2>
                <p>{property.nbanios}</p>
            </CardFooter>

        </Card>
    )
}

export default PropertyCard;