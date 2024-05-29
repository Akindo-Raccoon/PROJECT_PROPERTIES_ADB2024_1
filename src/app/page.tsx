import Navbar from "@/components/NavBar";
import { Calendar } from "@nextui-org/react";
import React from "react";

const home = () => {

  return (
    <main>
      <div className="navi">
        <Navbar />
      </div>
      <div className="cal">
          <Calendar showShadow={true} showMonthAndYearPickers={true} calendarWidth={5}/>
      </div>
      <div className="slid">

      </div> 
    </main>
  )
};

export default home;