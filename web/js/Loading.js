function Loading() {
    try {
        return (
            <div data-name="loading-container" className="flex justify-start mb-4">
                <div data-name="loading-content" className="bg-gray-100 rounded-lg px-4 py-2 rounded-bl-none">
                    <div data-name="loading-dots" className="flex space-x-2">
                        {[1, 2, 3].map((dot) => (
                            <div
                                key={dot}
                                className="w-2 h-2 bg-gray-400 rounded-full typing-indicator"
                                style={{ animationDelay: `${dot * 0.2}s` }}
                            ></div>
                        ))}
                    </div>
                </div>
            </div>
        );
    } catch (error) {
        console.error('Loading error:', error);
        reportError(error);
        return null;
    }
}
