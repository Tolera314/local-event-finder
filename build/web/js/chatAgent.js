function chatAgent(question, chatHistory) {
    const systemPrompt = `You are a helpful assistant.

Chat history:
${JSON.stringify(chatHistory)}`;
    
    return invokeAIAgent(systemPrompt, question);
}
