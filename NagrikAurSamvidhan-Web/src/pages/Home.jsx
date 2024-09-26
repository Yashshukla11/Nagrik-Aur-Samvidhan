import React, { Component } from 'react'
import ReactDOM from 'react-dom';
import "react-responsive-carousel/lib/styles/carousel.min.css";
import { Carousel } from 'react-responsive-carousel';
import const3 from '../assets/const3.jpg'
import const4 from '../assets/const4.jpg'
import const1 from '../assets/const1.jpg';
import constvideo from '../assets/constvideo.mp4'

import Timeline from '../components/Timeline';
import PhotoGrid from '../components/PhotoGrid';
import Videobg from '../components/Videobg';
import WhatsNewGrid from '../components/Whatsnew';
import phoneimg from "../assets/phone.png"
import { LuDownload } from "react-icons/lu";



const Home = () => {

  return (
    <div className="relative bg-white shadow-md"> 
      <Carousel
        showArrows={true}
        showThumbs={false}
        showStatus={false}
        infiniteLoop={true}
        autoPlay={true}
        interval={2000}
      >
        
        <div>
          <img
            src={const1}
            alt="dailyquiz"
            className="h-[60vh] w-full object-cover " 
          />
          <div className="absolute top-0 left-0 w-full h-full flex flex-col justify-center items-start p-8 bg-gradient-to-r from-black/70 to-transparent">
            <h2 className="text-white text-5xl font-bold m-4">Daily Constitution Quiz</h2>
            <button className="bg-amber-600 text-white font-semibold m-4 px-4 py-2 rounded-md">Play the Quiz</button>
          </div>
        </div>

        
        <div>
          <img
            src={const3}
            alt="article of the day"
            className="h-[60vh] w-full object-cover"
          />
          <div className="absolute top-0 left-0 w-full h-full flex flex-col justify-center items-start p-8 bg-gradient-to-r from-black/70 to-transparent">
            <h2 className="text-white text-5xl font-bold m-4">Article of the Day</h2>
            <button className="bg-amber-600 text-white font-semibold m-4 px-4 py-2 rounded-md">Learn More</button>
          </div>
        </div>
        <div>
          <img
            src={const4}
            alt="Latest Constitution Amendements"
            className="h-[60vh] w-full"
          />
          <div className="absolute top-0 left-0 w-full h-full flex flex-col justify-center items-start p-8 bg-gradient-to-r from-black/70 to-transparent">
            <h2 className="text-white text-5xl font-bold m-4">Latest Constitution Amendements</h2>
            <button className="bg-amber-600 text-white font-semibold m-4 px-4 py-2 rounded-md">Learn More</button>
          </div>
        </div>

       
      </Carousel>
      <WhatsNewGrid/>
      <Timeline/>
      <PhotoGrid/>
      {/* <div className="relative h-[70vh] w-full overflow-hidden mt-20 border-4 border-amber-700">
      <video
        className="absolute top-0 left-0 w-full h-full object-cover"
        autoPlay muted loop playsInline
      >
        <source src={constvideo} type="video/mp4" />
      </video>
      </div> */}
      <Videobg/>
      {/* <SwiperGallery/> */}
      
      <div className="flex justify-center md:min-w-[782px] flex-col md:flex-row pb-10">
        <div className="md:w-[50%]">
          <img src={phoneimg}  className="w-full h-auto  md:ml-20"/>
        </div>
        <div className="md:w-[50%] md:mr-20 flex flex-col items-center justify-center ">
        
          <p className='text-3xl mb-7'>Download Our App</p>
            <button className=' bg-black text-white text-2xl py-5 px-7 rounded-lg shadow-lg flex items-center 
            justify-center transition transform hover:bg-white hover:text-black hover:scale-105 '>
              Download <span className = "ml-2"><LuDownload /></span></button>
           <p className = 'mt-5 text-xl'> Dive into a new experience. </p><p  className = 'mt-2 text-xl'>Download the app and start exploring today! </p>
        </div>
        
    </div>
    
    </div>
  )
}

export default Home