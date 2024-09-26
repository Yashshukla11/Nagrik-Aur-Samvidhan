import React from 'react';
import { FaFlag, FaGavel, FaBalanceScale, FaUserEdit, FaVoteYea } from 'react-icons/fa';

const timelineEvents = [
  { date: '1947', description: 'India gains Independence from British rule.', icon: <FaFlag size={20} /> },
  { date: '1949', description: 'The Constitution of India is adopted on 26th November.', icon: <FaGavel size={20} /> },
  { date: '1950', description: 'The Constitution of India comes into effect on 26th January.', icon: <FaBalanceScale size={20} /> },
  { date: '1976', description: '42nd Amendment introduces the word "Secular" and "Socialist" in the Preamble.', icon: <FaUserEdit size={20} /> },
  { date: '1989', description: 'Constitution amended to lower the voting age from 21 to 18.', icon: <FaVoteYea size={20} /> },
  { date: '2019', description: '104th Amendment abolishes the two nominated Anglo-Indian seats in the Lok Sabha.', icon: <FaGavel size={20} /> }
];

const Timeline = () => {
  return (
    <div className="flex flex-col my-24 pt-6 justify-center items-center bg-yellow-100 mx-72 rounded-xl shadow-2xl  bg-gradient-to-tr from-gray-100 to-amber-200">
      <h1 className="text-4xl font-bold mb-12 text-center text-amber-700">Timeline of the Indian Constitution</h1>
      <ol className="relative border-l border-green-700">
        {timelineEvents.map((event, index) => (
          <li key={index} className="mb-10 ml-6">
            <div className="absolute w-8 h-8 bg-green-700 rounded-full -left-4 flex items-center justify-center text-white">
              {event.icon}
            </div>
            <div className="pl-10">
              <time className="mb-1 text-xl font-bold leading-none text-amber-700">{event.date}</time>
              <p className="text-lg font-semibold text-green-700">{event.description}</p>
            </div>
          </li>
        ))}
      </ol>
    </div>
  );
};

export default Timeline;

