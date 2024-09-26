import React, { useState } from 'react'; 
import Hero from '../components/Hero.jsx'; // Correct the import path

import Plan from '../components/Plan.jsx'
import ImageSlider from '../components/ImageSlider.jsx';
const About = () => {
  return (
    <div>
      <ImageSlider />
      <Plan />
      <Hero />
    </div>
  )
}

export default About