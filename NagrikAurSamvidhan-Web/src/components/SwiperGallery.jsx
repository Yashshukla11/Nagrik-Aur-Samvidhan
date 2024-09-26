
import React from 'react';
import { Swiper, SwiperSlide } from 'swiper/react';
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';
import 'swiper/css/autoplay';
import { Navigation, Pagination, Autoplay } from 'swiper/modules';
import cover from '../assets/cover.jpg'
import inscribe from '../assets/inscription.jpg'
import prasad from '../assets/prasad.jpg'
import sardar from '../assets/sardar.jpg'
import sessionca from '../assets/sessionca.jpg'
import assembly from '../assets/assembly.jpg'





const images = [
  (cover), (assembly), (prasad),
  (inscribe),(sardar), (sessionca)
];

const SwiperGallery = () => {
  return (
    <div className="bg-white p-2 mt-24 mb-24">
      <Swiper
        modules={[Navigation, Pagination, Autoplay]}
        spaceBetween={5}
        slidesPerView={4}
        navigation
        pagination={{ clickable: true }}
        autoplay={{ delay: 2000 }}
        loop={true}
        className="rounded-lg"
      >
        {images.map((src, index) => (
          <SwiperSlide key={index}>
            <img
              src={src}
              alt={`Slide ${index + 1}`}
              className="w-full object-cover h-60 rounded-md border-4 border-yellow-800 mt-10"
            />
          </SwiperSlide>
        ))}
      </Swiper>
    </div>
  );
};

export default SwiperGallery;
