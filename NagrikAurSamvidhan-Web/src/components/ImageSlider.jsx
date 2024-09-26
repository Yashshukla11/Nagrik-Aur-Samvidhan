import React, { useState } from 'react';
import { FaArrowLeft, FaArrowRight } from 'react-icons/fa';
import { RxDotFilled } from 'react-icons/rx';

import supremeCourt from '../assets/sliderImages/supremeCourt.jpg'; 
import ladyJustice from '../assets/sliderImages/ladyJustice.jpg'; 
import preamble from '../assets/sliderImages/preamble.jpg'; 
import bot from '../assets/sliderImages/bot.jpg'; 

const ImageSlider = () => {
    const slides = [
        { url: supremeCourt, title: 'Supreme Court of India' },
        { url: ladyJustice, title: 'Lady Justice' },
        { url: preamble, title: 'Indian Constitution Preamble' },
        { url: bot, title: 'Legal Documents' },
    ];

    const [currentIndex, setCurrentIndex] = useState(0);

    const prevSlide = () => {
        const isFirstSlide = currentIndex === 0;
        const newIndex = isFirstSlide ? slides.length - 1 : currentIndex - 1;
        setCurrentIndex(newIndex);
    };

    const nextSlide = () => {
        const isLastSlide = currentIndex === slides.length - 1;
        const newIndex = isLastSlide ? 0 : currentIndex + 1;
        setCurrentIndex(newIndex);
    };

    const goToSlide = (slideIndex) => {
        setCurrentIndex(slideIndex);
    };

    return (
        <div className='w-full max-w-[1200px] mx-auto my-4 flex flex-col md:flex-row bg-orange-100 rounded-lg shadow-lg overflow-hidden'>
            {/* Text Section */}
            <div className='flex-1 p-4 md:p-6 lg:p-8 bg-gray-100 rounded-lg shadow-md'>
                <h2 className='text-xl md:text-2xl lg:text-3xl font-bold mb-4 text-gray-800'>Nagrik Aur Samvidhan</h2>
                <p className='text-sm md:text-base mb-3 font-semibold text-gray-700'>
                    Nagrik Aur Samvidhan (Citizen & Constitution) is a pioneering initiative aimed at promoting constitutional literacy among citizens of all ages. Our mission is to simplify and spread knowledge about the Indian Constitution, ensuring that every individual can make informed decisions about their rights and duties.
                </p>
                <h2 className='text-xl md:text-2xl lg:text-3xl font-bold mb-4 text-gray-800'>Our Vision</h2>
                <p className='text-sm md:text-base mb-3 font-semibold text-gray-700'>
                    We envision a society where constitutional knowledge is widespread and accessible. Our platform is dedicated to making the Indian Constitution clear and comprehensible for everyone, fostering an informed and engaged citizenry.
                </p>
                <h2 className='text-xl md:text-2xl lg:text-3xl font-bold mb-4 text-gray-800'>Our Mission</h2>
                <ul className='list-disc pl-5 text-gray-700 text-sm md:text-base'>
                    <li className='font-medium mb-3'>
                        <span className='font-semibold text-gray-800'>Simplifies Constitutional Language:</span> Breaking down complex legal terms and concepts into easy-to-understand content.
                    </li>
                    <li className='font-medium mb-3'>
                        <span className='font-semibold text-gray-800'>Engages Users:</span> Offering interactive elements such as quizzes and educational games to make learning about the Constitution fun and effective.
                    </li>
                    <li className='font-medium'>
                        <span className='font-semibold text-gray-800'>Connects Real-Life Issues:</span> Highlighting recent community problems to demonstrate the practical application of constitutional laws.
                    </li>
                </ul>
            </div>

            {/* Image Slider Section */}
            <div className='flex-1 relative'>
                <div
                    className='w-full h-[300px] md:h-[400px] lg:h-[500px] xl:h-[600px] bg-center bg-cover transition-transform duration-500'
                    style={{ backgroundImage: `url(${slides[currentIndex].url})` }}
                >
                    {/* Left Arrow */}
                    <div className='absolute top-1/2 left-2 md:left-4 lg:left-6 xl:left-8 transform -translate-y-1/2 bg-black/50 p-2 rounded-full text-white cursor-pointer'>
                        <FaArrowLeft onClick={prevSlide} size={24} />
                    </div>
                    {/* Right Arrow */}
                    <div className='absolute top-1/2 right-2 md:right-4 lg:right-6 xl:right-8 transform -translate-y-1/2 bg-black/50 p-2 rounded-full text-white cursor-pointer'>
                        <FaArrowRight onClick={nextSlide} size={24} />
                    </div>
                </div>
                {/* Dots */}
                <div className='absolute bottom-2 md:bottom-4 lg:bottom-6 xl:bottom-8 left-1/2 transform -translate-x-1/2 flex space-x-2'>
                    {slides.map((_, slideIndex) => (
                        <div
                            key={slideIndex}
                            className={`text-xl cursor-pointer ${currentIndex === slideIndex ? 'text-blue-600' : 'text-white'}`}
                            onClick={() => goToSlide(slideIndex)}
                        >
                            <RxDotFilled />
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
};

export default ImageSlider;
