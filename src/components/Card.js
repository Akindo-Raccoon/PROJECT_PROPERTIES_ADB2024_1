import { Card, CardHeader, CardBody, CardFooter } from "@nextui-org/card";
import { Image } from "@nextui-org/image";

const card = ({ title, description, image }) => {
    return (
        <Card>
            <CardHeader>
                <p>{title}</p>
            </CardHeader>
            <CardBody>
                <Image
                    width="" alt="" src="" />
            </CardBody>
            <CardFooter>
                <p>{description}</p>
            </CardFooter>
        </Card>
    )
};

export default card;