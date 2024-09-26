import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import { useUser } from '../login/UserContext';

const Login = ({ toggleForm }) => {
  const [email, setEmail] = useState(''); 
  const [password, setPassword] = useState(''); 
  const [showPassword, setShowPassword] = useState(false); 
  const [error, setError] = useState('');
  const navigate = useNavigate(); 
  const { setUser } = useUser(); 

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const response = await axios.post('https://nagrikaursamvidhan-backend.onrender.com/user/login', {
        email,
        password,
      });

      console.log('Login successful:', response.data);
      setUser(response.data.user); 
      localStorage.setItem('user', JSON.stringify(response.data.user)); 
      navigate('/'); 
    } catch (err) {
      console.error('Login failed:', err.response ? err.response.data : err.message);
      setError('Login failed. Please check your credentials.');
    }
  };

  return (
    <div className="bg-gradient-to-br from-amber-100 via-white to-green-200 p-8 rounded-lg shadow-lg max-w-md w-full">
      <div className="flex border-b mb-6">
        <button
          className="py-2 px-4 text-gray-600 font-semibold"
          onClick={toggleForm}
        >
          SIGN UP
        </button>
        <button className="py-2 px-4 text-green-600 border-b-2 border-green-600 font-semibold">
          SIGN IN
        </button>
      </div>
      <h2 className="text-2xl font-semibold mb-6">Already have an account?</h2>
      
      <form onSubmit={handleSubmit}> 

    
        <div className="mb-4">
          <label className="block text-gray-700 font-medium mb-2">
            Email: *
          </label>
          <input
            type="email"
            placeholder="Email"
            value={email}
            onChange={(e) => setEmail(e.target.value)} 
            required
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-600 focus:border-transparent"
          />
        </div>
        
        <div className="mb-4 relative">
          <label className="block text-gray-700 font-medium mb-2">
            Password: *
          </label>
          <input
            type={showPassword ? 'text' : 'password'}
            placeholder="Password"
            value={password}
            onChange={(e) => setPassword(e.target.value)} 
            required
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-600 focus:border-transparent"
          />
          <span
            className="mt-7 absolute inset-y-0 right-0 pr-3 flex items-center text-sm leading-5 cursor-pointer"
            onClick={() => setShowPassword(!showPassword)} 
          >
            {showPassword ? 'Hide' : 'Show'}
          </span>
        </div>

        {error && <p className="text-red-500 text-sm">{error}</p>} {/* Show error if login fails */}

        <button
          type="submit"
          className="w-full py-2 px-4 bg-green-600 hover:bg-green-700 text-white font-medium rounded-md text-sm"
        >
          LOGIN
        </button>
       {/* <div className="text-right mt-4">
          <a
            href="#"
            className="text-green-600 hover:underline text-sm font-medium"
          >
            Forgot Password?
          </a>
       
        </div>
        */}
      </form>

      <div className="mt-6 text-center text-sm text-gray-600">
        For any issues or assistance, email{' '}
        <a
          href="mailto:nagriksamvidhan@gmail.com"
          className="text-green-600 hover:underline"
        >
          nagriksamvidhan@gmail.com
        </a>
      </div>
    </div>
  );
};

export default Login;
