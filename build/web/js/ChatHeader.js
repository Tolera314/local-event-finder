function ChatHeader() {
    try {
        return (
            <div data-name="chat-header" className="bg-white border-b border-gray-200 p-4 flex items-center justify-between">
                <div data-name="chat-header-left" className="flex items-center space-x-3">
                    <img 
                        data-name="chat-avatar"
                        src="https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y" 
                        alt="Chat Bot" 
                        className="w-10 h-10 rounded-full"
                    />
                    <div data-name="chat-header-info">
                        <h1 className="font-semibold text-gray-800">Chat Assistant</h1>
                        <p className="text-sm text-green-500">Online</p>
                    </div>
                </div>
            </div>
        );
    } catch (error) {
        console.error('ChatHeader error:', error);
        reportError(error);
        return null;
    }
}
