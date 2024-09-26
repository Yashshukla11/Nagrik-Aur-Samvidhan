import React from "react";
import { FaBalanceScale,FaBookOpen,FaShieldAlt, FaEquals,FaHandsHelping, FaGraduationCap,FaChalkboardTeacher, FaGavel } from "react-icons/fa";
import { GiHummingbird } from "react-icons/gi";
const Rights=()=>{
   
    return(
        
        <div className="min-h-screen p-10">
            
      <div className="max-w-7xl mx-auto shadow-lg rounded-lg overflow-hidden">
        <header className="bg-lime-100 p-6">
          <h1 className="text-4xl font-semibold text-gray-800 text-center">
          Fundamental Rights of India (PART III)
          </h1>
        </header>
        <div className="p-10 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
         <a href="\articlesummary\Articles 12-13">
          <div className="bg-white p-6 rounded-lg shadow-md flex flex-col items-center text-center duration-[300ms] hover:scale-105 hover:shadow-gray-400">
            <FaBalanceScale size={50} className="text-rose-900 mb-4" />
            
            <h2 className="text-2xl font-semibold text-[#351E12]">Article 12-13</h2>
            <p className="mt-4 text-gray-700">
            General
            </p>
          </div>
          </a>
          <a href="\articlesummary\Articles 14-18">
          <div className="bg-white p-6 rounded-lg shadow-md flex flex-col items-center text-center duration-[300ms] hover:scale-105 hover:shadow-gray-400">
            <GiHummingbird size={50} className="text-teal-900 mb-4" />
            
            <h2 className="text-2xl font-semibold text-[#351E12 ]">Article 14-18</h2>
            <p className="mt-4 text-gray-700">
            Right to Equality
            </p>
          </div>
        </a>
        <a href="\articlesummary\Articles 19-22">
          <div className="bg-white p-6 rounded-lg shadow-md flex flex-col items-center text-center duration-[300ms] hover:scale-105 hover:shadow-gray-400">
            <FaHandsHelping size={50} className="text-blue-900 mb-4" />
            <h2 className="text-2xl font-semibold text-[#351E12]">Article 19-22</h2>
            <p className="mt-4 text-gray-700">
            Right to Freedom
            </p>
          </div>
        </a> 
        <a href="\articlesummary\Articles 23-24">
          <div className="bg-white p-6 rounded-lg shadow-md flex flex-col items-center text-center duration-[300ms] hover:scale-105 hover:shadow-gray-400">
            <FaEquals  size={50} className="text-black-900 mb-4" />
            <h2 className="text-2xl font-semibold text-[#351E12]">Article 23-24</h2>
            <p className="mt-4 text-gray-700">
            Right against Exploitation
            </p>
          </div>
        </a>
        <a href="\articlesummary\Articles 25-28">
          <div className="bg-white p-6 rounded-lg shadow-md flex flex-col items-center text-cente duration-[300ms] hover:scale-105 hover:shadow-gray-400">
            <FaGraduationCap size={50} className="text-yellow-600 mb-4" />
            <h2 className="text-2xl font-semibold text-[#351E12]">Article 25-28</h2>
            <p className="mt-4 text-gray-700">
            Right to Freedom of Religion</p>
          </div>
        </a>
        <a href="\articlesummary\Articles 29-30">
          <div className="bg-white p-6 rounded-lg shadow-md flex flex-col items-center text-center duration-[300ms] hover:scale-105 hover:shadow-gray-400">
            <FaChalkboardTeacher size={50} className="text-orange-700 mb-4" />
            <h2 className="text-2xl font-semibold text-[#351E12]">Article 29-30</h2>
            <p className="mt-4 text-gray-700">
            Cultural and Educational Rights
            </p>
          </div>
          </a>
          <a href="\articlesummary\Article 31">
          <div className="bg-white p-6 rounded-lg shadow-md flex flex-col items-center text-center duration-[300ms] hover:scale-105 hover:shadow-gray-400">
            <FaBookOpen size={50} className="text-green-700 mb-4" />
            <h2 className="text-2xl font-semibold text-[#351E12]">Article 31</h2>
            <p className="mt-4 text-gray-700">
            Right to Property </p>
          </div>
          </a>
          <a href="\articlesummary\Article 31A">
          <div className="bg-white p-6 rounded-lg shadow-md flex flex-col items-center text-center duration-[300ms] hover:scale-105 hover:shadow-gray-400">
            <FaShieldAlt size={50} className="text-amber-900 mb-4" />
            <h2 className="text-2xl font-semibold text-[#351E12]">Article 31A-31D</h2>
            <p className="mt-4 text-gray-700">
            Saving of Certain Laws
            </p>
          </div>
          </a>
          <a href="\articlesummary\Articles 32-35">
          <div className="bg-white p-6 rounded-lg shadow-md flex flex-col items-center text-center duration-[300ms] hover:scale-105 hover:shadow-gray-400">
            <FaGavel size={50} className="text-amber-900 mb-4" />
            <h2 className="text-2xl font-semibold text-[#351E12]">Article 32-35</h2>
            <p className="mt-4 text-gray-700">
            Right to Constitutional Remedies
            </p>
          </div>
          </a>
        </div>
      </div>

    </div>
        
    )
};
export default Rights;