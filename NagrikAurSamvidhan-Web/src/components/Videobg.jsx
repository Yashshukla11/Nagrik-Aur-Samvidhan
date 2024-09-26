import React, { useEffect, useState } from 'react';
import constvideo from '../assets/constvideo.mp4'

const Videobg = () => {
  const [isLoaded, setIsLoaded] = useState(false);

  useEffect(() => {
    const handleLoad = () => setIsLoaded(true);
    const videoElement = document.getElementById('background-video');
    videoElement.addEventListener('loadeddata', handleLoad);
    return () => {
      videoElement.removeEventListener('loadeddata', handleLoad);
    };
  }, []);

  return (
    <div className={`relative h-[70vh] w-full overflow-hidden mt-20 border-4 border-amber-700 ${isLoaded ? 'opacity-100' : 'opacity-0 transition-opacity duration-500'}`}>
      <video
        id="background-video"
        className="absolute top-0 left-0 w-full h-full object-cover"
        autoPlay
        muted
        loop
        playsInline
        preload="metadata"
      >
        <source src={constvideo} type="video/mp4" />
      </video>
      
    </div>
  );
};

export default Videobg;
