/* global ReactDOM */

function App() {
    try {
        const [messages, setMessages] = React.useState([]);
        const [isLoading, setIsLoading] = React.useState(false);
        const chatContainerRef = React.useRef(null);

        React.useEffect(() => {
            if (chatContainerRef.current) {
                chatContainerRef.current.scrollTop = chatContainerRef.current.scrollHeight;
            }
        }, [messages]);

        const handleSendMessage = async (message) => {
            try {
                const userMessage = { content: message, isUser: true };
                setMessages(prev => [...prev, userMessage]);
                setIsLoading(true);

                const response = await chatAgent(message, messages);
                
                const botMessage = { content: response, isUser: false };
                setMessages(prev => [...prev, botMessage]);
            } catch (error) {
                console.error('Failed to send message:', error);
            } finally {
                setIsLoading(false);
            }
        };

        return (
            <div data-name="chat-app" className="min-h-screen bg-gray-50">
                <div data-name="chat-wrapper" className="max-w-3xl mx-auto bg-white shadow-lg">
                    <ChatHeader />
                    
                    <div 
                        data-name="messages-container"
                        ref={chatContainerRef}
                        className="chat-container p-4"
                    >
                        {messages.map((msg, index) => (
                            <ChatMessage 
                                key={index}
                                message={msg.content}
                                isUser={msg.isUser}
                            />
                        ))}
                        {isLoading && <Loading />}
                    </div>

                    <ChatInput onSendMessage={handleSendMessage} />
                </div>
            </div>
        );
    } catch (error) {
        console.error('App error:', error);
        reportError(error);
        return null;
    }
}

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);
