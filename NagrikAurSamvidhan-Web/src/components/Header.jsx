import React from 'react';
import emblem from '../assets/emblem.png'
import g20 from '../assets/g20.png'

const Header = () => {
  return (
    <header className="bg-white px-4 py-2 shadow-md flex justify-between items-center">
      <div className="flex items-center ml-4">
        <img
          src={emblem}
          className="h-16 w-auto mr-4"
        />
        <div>
            <div className=" items-center mr-4 ">
            
            <h1 className="md:text-xl text-md font-bold text-gray-900">नागरिक और संविधान</h1>
            <p className="md:text-sm text-xs text-gray-500">Constitution made easy </p>
            
            </div>
        </div>

      </div>
      <img src={g20} alt="g20 logo" width={150}/>
    </header>
  );
};

export default Header;
