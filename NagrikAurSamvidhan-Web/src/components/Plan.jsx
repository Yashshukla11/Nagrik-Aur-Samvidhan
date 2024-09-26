import React from 'react';

import gifImage from '../assets/features/quizzy.gif'; 
import newsImage from '../assets/features/law.jpg'; 
import botImage from '../assets/features/chatbot.jpg'; 
import videoThumbnail from '../assets/features/mcq.jpg'; 
import quizImage from '../assets/features/chotuQuiz.jpg'; 

const Plan = () => {
  return (
    <div className='max-w-[1400px] m-auto py-16 px-4 grid lg:grid-cols-2 gap-8 bg-green-100'>
      {/* Left side */}
      <div className='grid grid-cols-2 grid-rows-6 gap-2 h-[80vh]'>
        <img className='row-span-4 object-cover w-full h-full rounded-lg shadow-lg' src={gifImage} alt="GIF" />
        <img className='row-span-2 object-cover w-full h-full rounded-lg shadow-lg' src={newsImage} alt="News" />
        <img className='row-span-3 object-cover w-full h-full rounded-lg shadow-lg' src={botImage} alt="Bot" />
        <img className='row-span-2 object-cover w-full h-full rounded-lg shadow-lg' src={videoThumbnail} alt="Video Thumbnail" />
        <img className='row-span-2 object-cover w-full h-full rounded-lg shadow-lg' src={quizImage} alt="Quiz" />
      </div>
      
      {/* Right side */}
      <div className='flex flex-col h-full justify-center'>
        <h3 className='text-4xl md:text-5xl font-bold mb-6 text-gray-800'>Our Platform Features</h3>
        <p className='text-base mb-6 font-semibold text-gray-700'>
          The "Nagrik Aur Samvidhan" section offers engaging tools like quizzes, real-world case studies, and visual content to simplify constitutional learning. Personalized profiles further enhance the user experience by tailoring content to individual needs.
        </p>
        <ul className='space-y-4 mb-6 text-gray-700'>
          <li className='flex items-start text-base font-medium'>
            <span className='inline-block mt-2 w-2.5 h-2.5 mr-3 bg-orange-500 rounded-full'></span>
            Interactive Quizzes
          </li>
          <li className='flex items-start text-base font-medium'>
            <span className='inline-block mt-2 w-2.5 h-2.5 mr-3 bg-orange-500 rounded-full'></span>
            Recent Issues and Judgments
          </li>
          <li className='flex items-start text-base font-medium'>
            <span className='inline-block mt-2 w-2.5 h-2.5 mr-3 bg-orange-500 rounded-full'></span>
            Personalized Chatbot for Constitutional Queries
          </li>
          <li className='flex items-start text-base font-medium'>
            <span className='inline-block mt-2 w-2.5 h-2.5 mr-3 bg-orange-500 rounded-full'></span>
            User Profiles
          </li>
        </ul>
        <div className='py-4'>
          <button className='bg-orange-500 text-white border border-transparent py-2 px-6 rounded-lg shadow-lg hover:bg-orange-600 transition duration-300'>
            Know More about Us
          </button>
        </div>
      </div>
    </div>
  );
};

export default Plan;
