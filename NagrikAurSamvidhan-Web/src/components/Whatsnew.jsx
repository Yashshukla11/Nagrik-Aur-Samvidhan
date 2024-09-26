import React from 'react';
import { FaLightbulb, FaMobileAlt, FaRegNewspaper, FaGlobe } from 'react-icons/fa'; // Importing icons from react-icons

const WhatsNewGrid = () => {
  return (
    <div className="w-full h-auto p-8 ">
      <h1 className="text-3xl font-bold mb-8 text-center text-white">What's New</h1>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-5xl mx-auto">
        {/* Card 1 */}
        <div className="flex flex-col items-center p-6 rounded-lg shadow-lg transform transition duration-300 hover:scale-105 hover:shadow-2xl bg-gradient-to-br from-amber-200 via-white to-green-200 animate-fadeSlideUp">
          <FaLightbulb size={40} className="text-amber-600 mb-4" />
          <h2 className="text-xl font-bold mb-2 text-green-700">New Features</h2>
          <p className="text-center text-gray-700">Discover the latest updates and features we've added to enhance your experience.</p>
        </div>

        {/* Card 2 */}
        <div className="flex flex-col items-center p-6 rounded-lg shadow-lg transform transition duration-300 hover:scale-105 hover:shadow-2xl bg-gradient-to-br  from-amber-200 via-white to-green-200 animate-fadeSlideUp">
          <FaMobileAlt size={40} className="text-amber-600 mb-4" />
          <h2 className="text-xl font-bold mb-2 text-green-700">Mobile Optimizations</h2>
          <p className="text-center text-gray-700">Our platform is now more optimized for mobile devices, ensuring a seamless experience on the go.</p>
        </div>

        {/* Card 3 */}
        <div className="flex flex-col items-center p-6 rounded-lg shadow-lg transform transition duration-300 hover:scale-105 hover:shadow-2xl bg-gradient-to-br  from-amber-200 via-white to-green-200 animate-fadeSlideUp">
          <FaRegNewspaper size={40} className="text-amber-600 mb-4" />
          <h2 className="text-xl font-bold mb-2 text-green-700">Latest Articles</h2>
          <p className="text-center text-gray-700">Stay informed with our latest articles, news, and insights from around the world.</p>
        </div>

        {/* Card 4 */}
        <div className="flex flex-col items-center p-6 rounded-lg shadow-lg transform transition duration-300 hover:scale-105 hover:shadow-2xl bg-gradient-to-br from-amber-200 via-white to-green-200 animate-fadeSlideUp">
          <FaGlobe size={40} className="text-amber-600 mb-4" />
          <h2 className="text-xl font-bold mb-2 text-green-700">Global Outreach</h2>
          <p className="text-center text-gray-700">We are expanding our reach globally, connecting with more communities and people.</p>
        </div>
      </div>
    </div>
  );
};

export default WhatsNewGrid;
