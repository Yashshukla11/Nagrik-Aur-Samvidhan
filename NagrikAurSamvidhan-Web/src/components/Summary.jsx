import React from "react";
import summarydata from "../articlesSummary.json"
function Summary (props){
    const data = summarydata[props.articlename];
    return(
        <div>
            <div className = "mt-20 mb-20 w-full p-10 bg-gray-100 shadow-2xl rounded-lg max-w-6xl mx-auto">
            <h1 className = "text-4xl font-bold text-center ">Summary of {props.articlename}</h1>
            <p className = "text-center mt-10">
                {data}
            </p>
            </div>
        </div>
    );
}
export default Summary;