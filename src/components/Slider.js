import { Slider } from "@nextui-org/slider";
import Card from "./Card";

const slider = ({ cards }) => {
    return (
        <Slider>
            {cards.map((card, index) => (
                <Card key={index} {...card} />
            ))}
        </Slider>
    )
};


