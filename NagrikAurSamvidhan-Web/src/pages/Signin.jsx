import React, { useState } from 'react';
import Signup from '../components/Signup';
import Login from '../components/Login';

const App = () => {
  const [isLogin, setIsLogin] = useState(true);

  const toggleForm = () => {
    setIsLogin(!isLogin);
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-100">
      {isLogin ? <Login toggleForm={toggleForm} /> : <Signup toggleForm={toggleForm} />}
    </div>
  );
};

export default App;
