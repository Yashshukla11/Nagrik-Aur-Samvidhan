import React, { useState } from 'react';
import axios from 'axios'; 
import { useNavigate } from 'react-router-dom';
const Signup = ({ toggleForm }) => {
  const [name, setName] = useState('');
  //const [userPhoto, setPhoto] = useState('');    
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [gender, setGender] = useState('Male'); 
  const [phoneNumber, setPhone] = useState('');
  const [age, setAge] = useState('');
  const [language, setLanguage] = useState('en'); 
  const [showPassword, setShowPassword] = useState(false);
  const navigate = useNavigate();
  const [error, setError] = useState('');
  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const response = await axios.post('https://nagrikaursamvidhan-backend.onrender.com/user/register', {
        name,
        //userPhoto,
        email,
        password,
        gender,
        phoneNumber,
        age,
        language,
      });

      console.log('Registration successful:', response.data);
      navigate('/registrationsuccesfull ', { state: { fromSignup: true } })
    } catch (err) {
      console.error('Registration failed:', err.response ? err.response.data : err.message);
      let errorMessage = 'Registration failed. Please check your credentials.';
      if (err.response && err.response.data) {
        errorMessage = err.response.data.message || 'An error occurred on the server';
      } else if (err.message) {
        errorMessage = err.message;
      } else {
      errorMessage = 'An unexpected error occurred';
    } 
      setError('Registration failed : ' + errorMessage);
    }
  };

  return (
    <div className="bg-gradient-to-br from-amber-100 via-white to-green-200 p-8 rounded-lg shadow-lg max-w-md w-[100%] m-10">
      <div className="flex border-b mb-6">
        <button className="py-2 px-4 text-green-600 border-b-2 border-green-600 font-semibold">
          SIGN UP
        </button>
        <button className="py-2 px-4 text-gray-600 font-semibold" onClick={toggleForm}>
          SIGN IN
        </button>
      </div>
      <h2 className="text-2xl font-semibold mb-6">Create Your Account</h2>

      <form onSubmit={handleSubmit}>
        {/* Name */}
        <div className="mb-4">
          <label className="block text-gray-700 font-medium mb-2">Name:</label>
          <input
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
            placeholder="Name"
            required
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-600 focus:border-transparent"
          />
        </div>
  

    
        {/* Photo                           requires Cloudinary to convert photo to url
                
          <div className="mb-4">
          <label className="block text-gray-700 font-medium mb-2">Upload Photo:</label>
          <input
            type="file"
            onChange={(e) => setPhoto(e.target.files[0])}
            accept="image/*" 
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-600 focus:border-transparent"
          />
        </div>
        */}



        {/* Email */}
        <div className="mb-4">
          <label className="block text-gray-700 font-medium mb-2">Email:</label>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="Email"
            required
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-600 focus:border-transparent"
          />
        </div>

        {/* Password */}
        <div className="mb-4 relative">
          <label className="block text-gray-700 font-medium mb-2">Password:</label>
          <input
            type={showPassword ? 'text' : 'password'}
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="Password"
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

        {/* Gender */}
        <div className="mb-4">
          <label className="block text-gray-700 font-medium mb-2">Gender:</label>
          <select
            value={gender}
            onChange={(e) => setGender(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-600 focus:border-transparent"
          >
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
          </select>
        </div>

        {/* Phone No */}
        <div className="mb-4">
          <label className="block text-gray-700 font-medium mb-2">Phone No:</label>
          <input
            type="text"
            value={phoneNumber}
            onChange={(e) => setPhone(e.target.value)}
            placeholder=""
            required
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-600 focus:border-transparent"
          />
        </div>

        {/* Age */}
        <div className="mb-4">
          <label className="block text-gray-700 font-medium mb-2">Age:</label>
          <input
            type="number"
            value={age}
            onChange={(e) => setAge(e.target.value)}
            placeholder="Age"
            required
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-600 focus:border-transparent"
          />
        </div>

        {/* Language */}
        <div className="mb-4">
          <label className="block text-gray-700 font-medium mb-2">Language:</label>
          <select
            value={language}
            onChange={(e) => setLanguage(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-600 focus:border-transparent"
          >
            <option value="bn">Bengali</option>
            <option value="en" select="selected">English</option>
            <option value="gu">Gujarati</option>
            <option value="hi">Hindi</option>
            <option value="kn">Kanada</option>
            <option value="ml">Malayalam</option>
            <option value="mr">Marathi</option>
            <option value="pa">Punjabi</option>
            <option value="ta">Tamil</option>

          </select>
        </div>

        <div className="mb-4 flex items-center">
          <input
            type="checkbox"
            className="mr-2 focus:ring-2 focus:ring-green-600 h-4 w-4 text-green-600 border-gray-300 rounded"
            required
          />
          <label className="text-gray-700 text-sm">
            I agree to the{' '}
            <a href="#" className="text-green-600 hover:underline">
              Terms
            </a>{' '}
            and{' '}
            <a href="#" className="text-green-600 hover:underline">
              Privacy Policy
            </a>
            .
          </label>
        </div>

        <button
          type="submit"
          className="w-full py-2 px-4 bg-green-600 hover:bg-green-700 text-white font-medium rounded-md text-sm"
        >
          REGISTER
        </button>


        {error && <p className="text-red-500 text-sm">{error}</p>}{/* Show error if registration fails */}

        
      </form>

      <div className="mt-6 text-center text-sm text-gray-600">
        For any issues or assistance, email{' '}
        <a href="mailto:nagriksamvidhan@gmail.com" className="text-green-600 hover:underline">
          nagriksamvidhan@gmail.com
        </a>
      </div>
    </div>
  );
};

export default Signup;
