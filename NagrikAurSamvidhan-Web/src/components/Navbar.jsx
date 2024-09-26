import React, { useState , useEffect } from 'react';
import { NavLink } from 'react-router-dom';
import logo from '../assets/logo.png';
import { MdQuiz, MdArrowDropDown, MdLibraryBooks } from "react-icons/md";
import { IoBookSharp , IoPerson} from "react-icons/io5";
import { TbBooks, TbWheel } from "react-icons/tb";
import { FaFlag, FaBriefcase } from "react-icons/fa6";
import { IoMdLogOut } from "react-icons/io";
import { useUser } from '../login/UserContext'; 
const Navbar = () => {
  const [activeDropdown, setActiveDropdown] = useState(null);
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [isLoginMenu, setLoginOpen] = useState(false);

  const {user, setUser } = useUser(); 

  const handleDropdownToggle = (dropdownName) => {
    setActiveDropdown(activeDropdown === dropdownName ? null : dropdownName);
  };

  const toggleMenu = () => {
    setIsMenuOpen(!isMenuOpen);
  };
  const loginMenu = () => {
    setLoginOpen(!isLoginMenu);
  };
  
  
  useEffect(() => {
    const storedUser = localStorage.getItem('user');
    if (storedUser) {
      setUser(JSON.parse(storedUser));
    }
  }, [setUser]);
  const logout=()=>{
    setActiveDropdown(null);
    localStorage.removeItem('user')
    setUser(null);
    
  }
  return (
    <div>
      <nav className="relative bg-yellow-100 p-2 text-lg z-40 hidden lg:flex">
        <div className="container mx-auto flex justify-between items-center">
          <div className="flex text-white font-bold text-xl mx-4">
            <img src={logo} width={50} alt="logo" />
            <NavLink to="/" className='p-3 text-xl text-green-800' onClick={() => setActiveDropdown(null)}>Samvichar</NavLink>
          </div>

          <ul className="flex font-semibold space-x-6 relative">
            <li><NavLink to="/" className={({ isActive }) => isActive ? 'text-amber-500' : "text-green-800  hover:text-amber-600 cursor-pointer"}>Home</NavLink></li>
            <li><NavLink to="/about" className={({ isActive }) => isActive ? 'text-amber-500' : "text-green-800  hover:text-amber-600"}>About</NavLink></li>

            <li className='text-green-800'>
              <button onClick={() => handleDropdownToggle('learn')} className="flex text-green-800 font-medium hover:text-amber-600 cursor-pointer">
                Learn <MdArrowDropDown className='text-green-800 pt-2' size={25} />
              </button>
              {activeDropdown === 'learn' && (
                <ul className="absolute top-full mt-4 w-max bg-white shadow-lg rounded-sm">
                  <li className="flex items-center px-4 py-2 hover:bg-amber-600 hover:text-white cursor-pointer">
                    <IoBookSharp className='w-7' />
                    <div className='p-2'>
                      <NavLink to="/learn/preamble" onClick={() => setActiveDropdown(null)}>Preamble</NavLink>
                      <p>Understand the Preamble of the Constitution.</p>
                    </div>
                  </li>
                  <li className="flex items-center px-4 py-2 hover:bg-amber-600 hover:text-white cursor-pointer">
                    <TbBooks className='w-7' />
                    <div className='p-2'>
                      <NavLink to="/learn/rights" onClick={() => setActiveDropdown(null)}>Fundamental Rights</NavLink>
                      <p>Explore fundamental rights given to every citizen.</p>
                    </div>
                  </li>
                  <li className="flex items-center px-4 py-2 hover:bg-amber-600 hover:text-white cursor-pointer">
                    <FaFlag className='w-7' />
                    <div className='p-2'>
                      <NavLink to="/learn/directiveprinciple" onClick={() => setActiveDropdown(null)}>Directive Principles of State Policy</NavLink>
                      <p>Learn about guidelines for law framing.</p>
                    </div>
                  </li>
                  <li className="flex items-center px-4 py-2 hover:bg-amber-600 hover:text-white cursor-pointer">
                    <FaBriefcase className='w-7' />
                    <div className='p-2'>
                      <NavLink to="/learn/duties" onClick={() => setActiveDropdown(null)}>Fundamental Duties</NavLink>
                      <p>Learn about the duties of every citizen.</p>
                    </div>
                  </li>
                </ul>
              )}
            </li>

            <li><NavLink to="/chatbot" className={({ isActive }) => isActive ? 'text-amber-500' : "text-green-800  hover:text-amber-600 cursor-pointer"}>ChatBot</NavLink></li>

            <li className='text-green-800'>
              <button onClick={() => handleDropdownToggle('quizzes')} className="flex text-green-800 font-medium hover:text-amber-600 cursor-pointer">
                Quizzes <MdArrowDropDown className='text-green-800 pt-2' size={25} />
              </button>
              {activeDropdown === 'quizzes' && (
                <ul className="absolute top-full mt-4 w-max bg-white shadow-lg rounded-sm">
                  <li className="flex items-center px-4 py-2 hover:bg-amber-600 hover:text-white cursor-pointer">
                    <MdQuiz className='w-7' />
                    <div className='p-2'>
                      <NavLink to="/quizzes/dailyquiz" onClick={() => setActiveDropdown(null)}>Quiz and Games</NavLink>
                      <p>Test your knowledge with our daily quizzes.</p>
                    </div>
                  </li>
                  <li className="flex items-center px-4 py-2 hover:bg-amber-700 hover:text-white">
                    <TbWheel className='w-7' />
                    <div className='p-2'>
                      <NavLink to="/quizzes/spin" onClick={() => setActiveDropdown(null)}>Spin the Wheel</NavLink>
                      <p>Try your luck with Spin the Wheel game.</p>
                    </div>
                  </li>
                </ul>
              )}
            </li>
          </ul>

          <ul className="flex space-x-6 relative">
            {
              user ? 
              
              (<button className = "" onClick={() => handleDropdownToggle('login')}><img src={user.userPhoto} alt="User Photo" className = "w-[50px] rounded-full border-2 border-gray-500 p-[2px]"/></button>) 
               : (
            <button><li><NavLink to="/signin" className="text-green-800 font-medium hover:text-amber-600 py-2 px-4 rounded-lg" onClick={() => setActiveDropdown(null)}>Sign In</NavLink></li></button>
          )}
            <button><li><NavLink to="/contact" className="text-white font-medium cursor-pointer py-2 px-4 bg-amber-500 rounded-lg mr-2" onClick={() => setActiveDropdown(null)}>Contact Us</NavLink></li></button>
              {activeDropdown === 'login' && (
                <ul className="absolute top-full mt-4 w-max bg-white shadow-lg rounded-sm">
                  <li className="flex items-center px-4 py-2 hover:bg-emerald-500 hover:text-white cursor-pointer">
                  <NavLink to="/profile" onClick={() => setActiveDropdown(null)}>
                    <div className="flex items-center space-x-1 p-2">
                    <IoPerson className='w-7' /> <p className="text-xl">Profile</p>
                    </div>
                    </NavLink>
                  </li>
                  <li className="flex items-center px-4 py-2 hover:bg-rose-400 hover:text-white">
                  <NavLink to="/signin" onClick={logout} >
                   <div className="flex items-center space-x-1 p-2">
                    <IoMdLogOut className='w-7' />

                     <p className="text-xl">Sign Out</p>               
                     </div>
                    </NavLink>
                   
                  </li>
                </ul>
              )}
          </ul>
        </div>
      </nav>

      <nav className="lg:hidden bg-yellow-100 p-4">
        <div className="container mx-auto flex justify-between items-center">
          <div className="text-green-800 text-xl font-bold flex inline items-center space-x-5 ">
          <img src={logo} width={50} alt="logo" />
            <NavLink to="/">Samvichar</NavLink>
          </div>
          
              
            
        <div className = "flex space-x-4">
          {user ? <button className = "" onClick={()=>{setIsMenuOpen(false); loginMenu()}}><img src={user.userPhoto} alt="User Photo" className = "w-[40px] rounded-full border-2 border-gray-500 p-[1px]"/></button>:<></>}
          <button onClick={()=>{toggleMenu(); setLoginOpen(false)}} className="text-green-800 focus:outline-none">
            
            <svg className="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 6h16M4 12h16M4 18h16"></path>
            </svg>
          </button>
        </div>
        </div>
        {isMenuOpen && (
          <ul className="mt-4 space-y-4 text-green-800 font-medium">
            <li><NavLink to="/" onClick={toggleMenu}>Home</NavLink></li>
            <li><NavLink to="/about" onClick={toggleMenu}>About</NavLink></li>
            <li><NavLink to="/learn" onClick={toggleMenu}>Learn</NavLink></li>
            <li><NavLink to="/quizzes" onClick={toggleMenu}>Quizzes</NavLink></li>
            {user ? <></> : <li><NavLink to="/signin" onClick={toggleMenu}>Sign In</NavLink></li>}
            <li><NavLink to="/contact" onClick={toggleMenu}>Contact Us</NavLink></li>
          </ul>
        )}
         {isLoginMenu && (
          <ul className=" mt-4 space-y-4 text-green-800 font-medium">
            <li><NavLink to="/profile" onClick={loginMenu}>Profile</NavLink></li>
            <li><NavLink to="/signin" onClick={()=>{loginMenu();logout();}}>Sign Out</NavLink></li>
          </ul>
        )}
      </nav>
    </div>
  );
};

export default Navbar;
