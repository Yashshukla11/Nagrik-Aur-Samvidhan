import React, { useState } from 'react';
import logoo from '../assets/logo.png';

const Chatbot = () => {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');
  const [showGrid, setShowGrid] = useState(true);

  const handleSend = () => {
    if (input.trim() === '') return;

    setMessages([...messages, { sender: 'You', content: input, type: 'sent' }]);
    setInput('');
    setShowGrid(false);

    setTimeout(() => {
      setMessages(prevMessages => [
        ...prevMessages,
        { sender: 'Nagrik Aur Samvidhan', content: 'Thank you for your message. I am processing it now.', type: 'received' }
      ]);
    }, 1000);
  };

  const handleGridClick = (topic) => {
    setShowGrid(false);
    setMessages([...messages, { sender: 'You', content: `I want to know more about ${topic}`, type: 'sent' }]);

    const responses = {
      'Fundamental Rights': 'Fundamental Rights are the basic human rights guaranteed by the Constitution of India. They include the right to equality, freedom of speech, and protection from discrimination.',
      'Directive Principles': 'Directive Principles of State Policy are guidelines for the framing of laws by the government. They aim to establish a just society by ensuring social and economic welfare.',
      'Fundamental Duties': 'Fundamental Duties are the moral obligations of all citizens to help promote a spirit of patriotism and to uphold the unity of India.',
      'Amendment Procedure': 'The Amendment Procedure allows for the modification of the Constitution to adapt to changing needs. It includes provisions for both simple and complex amendments.'
    };

    setTimeout(() => {
      setMessages(prevMessages => [
        ...prevMessages,
        { sender: 'Nagrik Aur Samvidhan', content: responses[topic], type: 'received' }
      ]);
    }, 1000);
  };

  return (
    <div className="w-full h-screen p-4 flex flex-col items-center bg-blue-100">
      <div className="w-full sm:w-full lg:w-3/4 h-[92vh] border border-gray-300 rounded-lg shadow-lg flex flex-col">
        
        {/* Header Section with Logo */}
        <div className="flex items-center justify-between p-4 border-b border-gray-300 bg-gray-200">
          <img src={logoo} alt="App Logo" className="h-12 w-auto" />
          <p className="text-2xl font-semibold">Nagrik Aur Samvidhan</p>
        </div>
        
        {/* Grid Layout Section */}
        {showGrid && (
          <div className="flex-1 flex items-center justify-center p-10 bg-white">
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 max-w-lg">
              <div
                className="bg-yellow-100 p-6 rounded-lg shadow-md hover:shadow-xl transition-shadow duration-300 cursor-pointer"
                onClick={() => handleGridClick('Fundamental Rights')}
              >
                <h3 className="text-gray-800 text-lg font-semibold">Fundamental Rights</h3>
              </div>
              <div
                className="bg-green-100 p-6 rounded-lg shadow-md hover:shadow-xl transition-shadow duration-300 cursor-pointer"
                onClick={() => handleGridClick('Directive Principles')}
              >
                <h3 className="text-gray-800 text-lg font-semibold">Directive Principles</h3>
              </div>
              <div
                className="bg-violet-200 p-6 rounded-lg shadow-md hover:shadow-xl transition-shadow duration-300 cursor-pointer"
                onClick={() => handleGridClick('Fundamental Duties')}
              >
                <h3 className="text-gray-800 text-lg font-semibold">Fundamental Duties</h3>
              </div>
              <div
                className="bg-red-200 p-6 rounded-lg shadow-md hover:shadow-xl transition-shadow duration-300 cursor-pointer"
                onClick={() => handleGridClick('Amendment Procedure')}
              >
                <h3 className="text-gray-800 text-lg font-semibold">Amendment Procedure</h3>
              </div>
            </div>
          </div>
        )}

        {/* Messages Section */}
        <div className="flex-1 p-4 bg-white overflow-y-auto" style={{ maxHeight: '55vh' }}>
          {messages.map((message, index) => (
            <div key={index} className={`flex ${message.type === 'sent' ? 'justify-end' : ''} mb-2`}>
              <div className={`max-w-xs p-2 rounded-lg ${message.type === 'sent' ? 'bg-orange-500 text-white' : 'bg-green-400'}`}>
                <p className="font-medium">{message.sender}</p>
                <p>{message.content}</p>
              </div>
            </div>
          ))}
        </div>

        {/* Input Section */}
        <div className="border-t border-gray-300 p-8 bg-gray-200 flex items-center">
          <input
            type="text"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            className="flex-1 p-2 border rounded-lg mr-2"
            placeholder="Ask a question..."
            onKeyDown={(e) => {
              if (e.key === 'Enter') handleSend();
            }}
          />
          <button
            onClick={handleSend}
            className="bg-orange-500 text-white px-4 py-2 rounded-lg"
          >
            Send
          </button>
        </div>
      </div>
    </div>
  );
};

export default Chatbot;
