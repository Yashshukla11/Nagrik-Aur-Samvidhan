import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Navbar from "./components/Navbar"
import Header from "./components/Header"
import Footer from "./components/Footer"
import Home from "./pages/Home" 
import About from './pages/About'
import Quizzes from './pages/Quizzes'
import Preamble from './pages/Preamble'
import Rights from './pages/Rights'
import Duties from './pages/Duties'
import Chatbot from './pages/Chatbot'
import Login from './pages/Signin'
import Contact from './pages/Contact'
import Profile from './pages/Profile'
import ArticleSummary from './pages/ArticleSummary';
import { UserProvider } from './login/UserContext';
import RegistrationDone from './components/RegistrationDone';
function App() {


  return (
    <UserProvider>
    <Router>
    <Header/>
    <Navbar/>
    
      <Routes>
        <Route path="/" element={<Home/>} />
        <Route path="/about" element={<About/>} />
        <Route path="/quizzes" element={<Quizzes />} />
        <Route path="/learn/preamble" element={<Preamble />}/>
        <Route path="/learn/rights" element={<Rights />}/>
        <Route path="/learn/duties" element={<Duties />}/>
        <Route path="/chatbot" element={<Chatbot />}/>
        <Route path = "/articlesummary/:artc" element={<ArticleSummary/>}/>
        <Route path = "/contact" element={<Contact/>}/>
        <Route path = "/signin" element={<Login/>}/>
        <Route path = "/profile" element={<Profile/>}/>
        <Route path = '/registrationsuccesfull' element={<RegistrationDone/>}/>
      </Routes>
      <Footer/>
    </Router>
    </UserProvider>
  )
}

export default App
