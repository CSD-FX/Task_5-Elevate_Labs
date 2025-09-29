class QuotesApp {
    constructor() {
        this.quotes = [
            { text: "The only way to do great work is to love what you do.", author: "Steve Jobs" },
            { text: "Innovation distinguishes between a leader and a follower.", author: "Steve Jobs" },
            { text: "Your time is limited, so don't waste it living someone else's life.", author: "Steve Jobs" },
            { text: "The future belongs to those who believe in the beauty of their dreams.", author: "Eleanor Roosevelt" },
            { text: "The way to get started is to quit talking and begin doing.", author: "Walt Disney" },
            { text: "Don't let yesterday take up too much of today.", author: "Will Rogers" },
            { text: "It's not whether you get knocked down, it's whether you get up.", author: "Vince Lombardi" },
            { text: "The only impossible journey is the one you never begin.", author: "Tony Robbins" },
            { text: "What you get by achieving your goals is not as important as what you become.", author: "Zig Ziglar" },
            { text: "Believe you can and you're halfway there.", author: "Theodore Roosevelt" }
        ];
        
        this.currentQuoteIndex = 0;
        this.quoteTextElement = document.getElementById('quoteText');
        this.quoteAuthorElement = document.getElementById('quoteAuthor');
        this.newQuoteBtn = document.getElementById('newQuoteBtn');
        this.podInfoElement = document.getElementById('podInfo');
        
        this.init();
    }
    
    init() {
        this.newQuoteBtn.addEventListener('click', () => this.showNewQuote());
        setInterval(() => this.showNewQuote(), 10000);
        this.showNewQuote();
        this.showPodInfo();
    }
    
    showNewQuote() {
        let newIndex;
        do {
            newIndex = Math.floor(Math.random() * this.quotes.length);
        } while (newIndex === this.currentQuoteIndex && this.quotes.length > 1);
        
        this.currentQuoteIndex = newIndex;
        const quote = this.quotes[this.currentQuoteIndex];
        
        this.quoteTextElement.style.opacity = '0';
        this.quoteAuthorElement.style.opacity = '0';
        
        setTimeout(() => {
            this.quoteTextElement.textContent = `"${quote.text}"`;
            this.quoteAuthorElement.textContent = `- ${quote.author}`;
            this.quoteTextElement.style.opacity = '1';
            this.quoteAuthorElement.style.opacity = '1';
        }, 300);
        
        this.newQuoteBtn.style.animation = 'none';
        setTimeout(() => {
            this.newQuoteBtn.style.animation = 'pulse 0.5s ease';
        }, 10);
    }
    
    showPodInfo() {
        // This would typically come from environment variables in a real K8s setup
        const podInfo = `Quotes App v1.0 | Kubernetes Ready`;
        this.podInfoElement.textContent = podInfo;
    }
}

// Add pulse animation
const style = document.createElement('style');
style.textContent = `
    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.05); }
        100% { transform: scale(1); }
    }
`;
document.head.appendChild(style);

// Initialize app
document.addEventListener('DOMContentLoaded', () => {
    new QuotesApp();
});