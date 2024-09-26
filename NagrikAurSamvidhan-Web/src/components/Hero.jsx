import React from 'react';
import { FaGithub, FaLinkedin, FaInstagram } from 'react-icons/fa'; // Imported icons

import khushboo from '../assets/Khushbu.png';
import garima from '../assets/garima.jpg';
import varun from '../assets/varun.jpg';
import swapnil from '../assets/swapnil.jpg';
import yash from '../assets/yash.jpg';
import utkarsh from '../assets/utkarsh.jpg';

const teamMembers = [
    {
        name: 'Yash Shukla',
        image: yash,
        cardColor: 'bg-teal-100',
        github: 'https://github.com/Yashshukla11',
        linkedin: 'https://www.linkedin.com/in/nightmareking/',
        instagram: 'https://www.instagram.com/yash_shukla11/'
    },
    {
        name: 'Swapnil Singh',
        image: swapnil,
        cardColor: 'bg-orange-100',
        github: 'https://github.com/hereisswapnil',
        linkedin: 'https://linkedin.com/in/hereisSwapnil',
        instagram: 'https://github.com/hereisswapnil '
    },
    {
        name: 'Utkarsh Sharma',
        image: utkarsh,
        cardColor: 'bg-pink-100',
        github: 'https://github.com/utkarshdev2411',
        linkedin: 'https://www.linkedin.com/in/utkarshdev2411/',
        instagram: 'https://www.instagram.com/utkarshdev2411/'
    },
    {
        name: 'Garima Singh',
        image: garima,
        cardColor: 'bg-green-100',
        github: 'https://github.com/Garimas10u',
        linkedin: 'https://www.linkedin.com/in/garimasingh10u/',
        instagram: 'https://instagram.com/garimasingh10u'
    },
    {
        name: 'Khushboo Kumari',
        image: khushboo,
        cardColor: 'bg-blue-100',
        github: 'https://github.com/rai-Khushboo',
        linkedin: 'https://www.linkedin.com/in/khushboo-kumari-b08973255/',
        instagram: 'https://instagram.com/khushboo_.rai'
    },
    {
        name: 'Varun Marwah',
        image: varun,
        cardColor: 'bg-yellow-100',
        github: 'https://github.com/varunmarwah',
        linkedin: 'https://github.com/Varun-047',
        instagram: 'https://github.com/Varun-047'
    }
];

const Hero = () => {
    return (
        <section className="py-12 bg-violet-100">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                <h2 className="text-3xl font-extrabold text-gray-900 mb-4">Meet Our Team</h2>
                <p className="text-lg text-gray-600 mb-8">
                    Our dedicated team is passionate about promoting constitutional literacy and empowering citizens. With diverse backgrounds and extensive experience, we are committed to making the Indian Constitution accessible and engaging for everyone.
                </p>

                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                    {teamMembers.map((member, index) => (
                        <div key={index} className={`flex flex-col items-center rounded-lg shadow-lg p-6 transition-transform transform hover:scale-105 hover:shadow-xl ${member.cardColor}`}>
                            <div className="w-56 h-56 lg:w-64 lg:h-64 rounded-full overflow-hidden bg-white flex items-center justify-center">
                                <img src={member.image} alt={member.name} className="w-full h-full object-cover rounded-full"/>
                            </div>
                            <h3 className="mt-6 text-xl font-semibold text-gray-900">{member.name}</h3>
                            <div className="flex space-x-4 mt-4">
                                {member.github && (
                                    <a href={member.github} target="_blank" rel="noopener noreferrer" className="text-gray-500 hover:text-gray-700">
                                        <FaGithub size={24} />
                                    </a>
                                )}
                                {member.linkedin && (
                                    <a href={member.linkedin} target="_blank" rel="noopener noreferrer" className="text-gray-500 hover:text-gray-700">
                                        <FaLinkedin size={24} />
                                    </a>
                                )}
                                {member.instagram && (
                                    <a href={member.instagram} target="_blank" rel="noopener noreferrer" className="text-gray-500 hover:text-gray-700">
                                        <FaInstagram size={24} />
                                    </a>
                                )}
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </section>
    );
};

export default Hero;
