import React from 'react';
import preambleimg from "../assets/preamble.jpg"
import Summary from '../components/Summary.jsx'
const Preamble=()=>{
    return(
        <div className="min-h-screen py-10">
      <div className="w-full p-10 mt-5 bg-[#f8faeb] shadow-2xl rounded-lg max-w-6xl mx-auto">
        <h1 className="text-6xl font-bold text-center text-[#0E0F02]">
          PREAMBLE
        </h1>
        <div className="mt-10 text-center space-y-4">
          <p className="text-xl font-bold text-[#5C614F] inline">
            WE, THE PEOPLE OF INDIA,
          </p>
          having solemnly resolved to constitute India into a
          <p className="text-xl font-bold text-[#5C614F] ">
            
            SOVEREIGN SOCIALIST SECULAR DEMOCRATIC REPUBLIC
          </p>
          and to secure to all its citizens:
          <p>
            <span className="text-xl font-bold text-[#5C614F]">JUSTICE,</span>
            social, economic and political;
          </p>
          <p>
            <span className="text-xl font-bold text-[#5C614F]">LIBERTY</span> of
            thought, expression, belief, faith and worship;
          </p>
          <p>
            <span className="text-xl font-bold text-[#5C614F]">EQUALITY</span>
            of status and of opportunity;
          </p>
          <p>and to promote among them all</p>
          <p>
            <span className="text-xl font-bold text-[#5C614F]">FRATERNITY</span>
            assuring the dignity of the individual and the unity and integrity
            of the Nation;
          </p>
          <p>
            <span className="text-xl font-bold text-[#5C614F]">
              IN OUR CONSTITUENT ASSEMBLY
            </span>
            this twenty-sixth day of November, 1949, do
            </p>
            <p>
            <span className="text-xl font-bold text-[#5C614F]">
              HEREBY ADOPT, ENACT AND GIVE TO OURSELVES THIS CONSTITUTION.
            </span>
            </p>
          
        </div>
      </div>

      <div className="flex flex-col md:flex-row mt-20 w-full max-w-6xl mx-auto space-y-10 md:space-y-0">
        <ul className="text-xl list-disc w-full md:w-1/2 ml-auto mr-auto md:leading-loose">
          <li>
            <span className="text-rose-900 font-semibold">Sovereign:</span>
            India is an independent nation, free to govern itself without any
            external control.
          </li>
          <li>
            <span className="text-rose-900 font-semibold">Socialist: </span>The
            country is committed to social and economic equality for all its
            citizens.
          </li>
          <li>
            <span className="text-rose-900 font-semibold">Secular:</span> India
            does not have an official religion and ensures equal respect and
            treatment for all religions.
          </li>
          <li>
            <span className="text-rose-900 font-semibold">Democratic:</span> The
            government is elected by the people through a system of free and
            fair elections.
          </li>
          <li>
            <span className="text-rose-900 font-semibold">Republic:</span> The
            head of state is elected, not a hereditary monarch.
          </li>
          <li>
            <span className="text-rose-900 font-semibold">Justice:</span> The
            Preamble promises social, economic, and political justice for all
            citizens.
          </li>
          <li>
            <span className="text-rose-900 font-semibold">Liberty:</span> It
            guarantees freedom of thought, expression, belief, faith, and
            worship.
          </li>
          <li>
            <span className="text-rose-900 font-semibold">Equality: </span>It
            ensures equal opportunity and status for all citizens.
          </li>
          <li>
            <span className="text-rose-900 font-semibold">Fraternity:</span> It
            promotes a sense of brotherhood and unity among the people, ensuring
            the dignity of the individual and the unity of the nation.
          </li>
        </ul>
        <div className="w-full md:w-1/2 flex justify-center md:justify-end">
          <img
            src={preambleimg}
            alt="Preamble Image"
            className="w-4/5 md:w-4/5 h-auto object-cover shadow-2xl rounded-2xl"
          />
        </div>
      </div>
      <Summary articlename = "Preamble"/>
    </div>
    
    )
};
export default Preamble;