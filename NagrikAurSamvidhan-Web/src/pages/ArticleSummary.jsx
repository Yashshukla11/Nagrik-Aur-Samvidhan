import React from "react";
import {useParams} from 'react-router-dom'
import Summary from "../components/Summary";

const ArticleSummary=()=>{
    const {artc} = useParams(); 
    return(
        <div>
            <Summary articlename = {artc}/>
        </div>
    );
}
export default ArticleSummary;