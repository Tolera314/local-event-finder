function ChatInput({ onSendMessage }) {
    try {
        const [message, setMessage] = React.useState('');

        const handleSubmit = (e) => {
            e.preventDefault();
            if (message.trim()) {
                onSendMessage(message);
                setMessage('');
            }
        };

        return (
            <form 
                data-name="chat-input-form"
                onSubmit={handleSubmit} 
                className="bg-white border-t border-gray-200 p-4"
            >
                <div data-name="input-container" className="flex space-x-4">
                    <input
                        data-name="message-input"
                        type="text"
                        value={message}
                        onChange={(e) => setMessage(e.target.value)}
                        placeholder="Type your message..."
                        className="flex-1 p-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500"
                    />
                    <button
                        data-name="send-button"
                        type="submit"
                        disabled={!message.trim()}
                        className="bg-blue-500 text-white px-6 py-2 rounded-lg hover:bg-blue-600 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                    >
                        <i className="fas fa-paper-plane"></i>
                    </button>
                </div>
            </form>
        );
    } catch (error) {
        console.error('ChatInput error:', error);
        reportError(error);
        return null;
    }
}
