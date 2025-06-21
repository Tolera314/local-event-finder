function ChatMessage({ message, isUser }) {
    try {
        return (
            <div 
                data-name="chat-message"
                className={`flex ${isUser ? 'justify-end' : 'justify-start'} mb-4 message-appear`}
            >
                <div 
                    data-name="message-content"
                    className={`max-w-[70%] rounded-lg px-4 py-2 ${
                        isUser 
                            ? 'bg-blue-500 text-white rounded-br-none' 
                            : 'bg-gray-100 text-gray-800 rounded-bl-none'
                    }`}
                >
                    <p className="text-sm">{message}</p>
                </div>
            </div>
        );
    } catch (error) {
        console.error('ChatMessage error:', error);
        reportError(error);
        return null;
    }
}
