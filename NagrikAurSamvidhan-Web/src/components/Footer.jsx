import React from 'react';
import { FaFacebook, FaInstagram, FaTwitter, FaLinkedin } from 'react-icons/fa';

const Footer = () => {
  return (
    <div className='w-full bg-gray-900 text-gray-300 py-8 px-2'>
      <div className='max-w-[1400px] mx-auto grid grid-cols-2 md:grid-cols-6 border-b-2 border-gray-600 py-8 px-4'>
        <div>
          <h6 className='font-bold uppercase pt-2'>Explore</h6>
          <ul>
            <li className='py-1'>Interactive Quizzes</li>
            <li className='py-1'>Recent Judgments</li>
            <li className='py-1'>Visual Summaries</li>
            <li className='py-1'>User Profiles</li>
            <li className='py-1'>Personalized Chatbot</li>
            <li className='py-1'>Citizen Rights</li>
            <li className='py-1'>Fundamental Duties</li>
            <li className='py-1'>Directive Principles</li>
          </ul>
        </div>
        <div>
          <h6 className='font-bold uppercase pt-2'>Support</h6>
          <ul>
            <li className='py-1'>FAQ</li>
            <li className='py-1'>Contact Us</li>
            <li className='py-1'>Terms of Service</li>
            <li className='py-1'>Privacy Policy</li>
            <li className='py-1'>Accessibility</li>
            <li className='py-1'>Help Center</li>
            <li className='py-1'>Community Guidelines</li>
          </ul>
        </div>
        <div>
          <h6 className='font-bold uppercase pt-2'>Company</h6>
          <ul>
            <li className='py-1'>About Us</li>
            <li className='py-1'>Blog</li>
            <li className='py-1'>Careers</li>
            <li className='py-1'>Press</li>
            <li className='py-1'>Partnerships</li>
            <li className='py-1'>Events</li>
            <li className='py-1'>Media Kit</li>
          </ul>
        </div>
        <div>
          <h6 className='font-bold uppercase pt-2'>Legal</h6>
          <ul>
            <li className='py-1'>Disclaimer</li>
            <li className='py-1'>Privacy Policy</li>
            <li className='py-1'>Terms of Use</li>
            <li className='py-1'>Guidelines</li>
            <li className='py-1'>Policies</li>
            <li className='py-1'>Cookie Policy</li>
            <li className='py-1'>Compliance</li>
          </ul>
        </div>

        <div className='col-span-2 py-8 md:pt-2'>
          <p className='font-bold uppercase'>Subscribe to our newsletter</p>
          <p className='py-4'>Stay updated with the latest insights and features related to constitutional literacy.</p>
          <form className='flex flex-col sm:flex-row'>
            <input className='w-full p-2 mr-4 rounded-md mb-4' type="email" placeholder="Enter your email..." />
            <button className="p-2 mb-4 bg-orange-600 text-white rounded-md">Subscribe</button>
          </form>
        </div>
      </div>
      <div className='flex flex-col max-w-[1400px] px-2 py-4 mx-auto justify-between sm:flex-row text-center text-gray-500'>
        <p className='py-4'>© 2024 Nagrik Aur Samvidhan. All rights reserved.</p>
        <div className='flex justify-between sm:w-[300px] mt-4 text-2xl'>
          <FaFacebook />
          <FaInstagram />
          <FaTwitter />
          <FaLinkedin />
        </div>
      </div>
    </div>
  );
};

export default Footer;
