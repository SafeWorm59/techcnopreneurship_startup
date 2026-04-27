import { Leaf, Twitter, Linkedin, Github } from "lucide-react";
import { Link } from "react-router";

export function Footer() {
  return (
    <footer className="bg-[#1B211A] border-t border-[#628141]/30 pt-16 pb-8">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-12 md:gap-8">
          <div className="col-span-1 md:col-span-2 space-y-4">
            <Link to="/" className="flex items-center gap-2 group w-fit">
              <div className="bg-[#628141] p-2 rounded-lg group-hover:bg-[#8BAE66] transition-colors">
                <Leaf className="w-5 h-5 text-[#1B211A]" />
              </div>
              <span className="font-bold text-xl tracking-tight text-[#EBD5AB]">EchoTrace.</span>
            </Link>
            <p className="text-[#8BAE66] max-w-sm text-sm leading-relaxed">
              Empowering Carbon Guardians in Bukidnon to turn standing trees into verifiable green capital, uniting local landowners with global Net-Zero initiatives.
            </p>
            <div className="flex gap-4 pt-2">
              <a href="#" className="text-[#EBD5AB] hover:text-[#8BAE66] transition-colors p-2 bg-[#628141]/20 rounded-full">
                <Twitter className="w-4 h-4" />
              </a>
              <a href="#" className="text-[#EBD5AB] hover:text-[#8BAE66] transition-colors p-2 bg-[#628141]/20 rounded-full">
                <Linkedin className="w-4 h-4" />
              </a>
              <a href="#" className="text-[#EBD5AB] hover:text-[#8BAE66] transition-colors p-2 bg-[#628141]/20 rounded-full">
                <Github className="w-4 h-4" />
              </a>
            </div>
          </div>
          
          <div>
            <h3 className="text-[#EBD5AB] font-semibold mb-4 tracking-wide">Platform</h3>
            <ul className="space-y-3">
              <li><Link to="/marketplace" className="text-[#8BAE66] hover:text-[#EBD5AB] text-sm transition-colors">Marketplace</Link></li>
              <li><Link to="/dashboard" className="text-[#8BAE66] hover:text-[#EBD5AB] text-sm transition-colors">Dashboard</Link></li>
              <li><a href="#" className="text-[#8BAE66] hover:text-[#EBD5AB] text-sm transition-colors">Our Technology</a></li>
              <li><a href="#" className="text-[#8BAE66] hover:text-[#EBD5AB] text-sm transition-colors">Verification Process</a></li>
            </ul>
          </div>

          <div>
            <h3 className="text-[#EBD5AB] font-semibold mb-4 tracking-wide">Resources</h3>
            <ul className="space-y-3">
              <li><a href="#" className="text-[#8BAE66] hover:text-[#EBD5AB] text-sm transition-colors">For Carbon Guardians</a></li>
              <li><a href="#" className="text-[#8BAE66] hover:text-[#EBD5AB] text-sm transition-colors">For Corporate Buyers</a></li>
              <li><a href="#" className="text-[#8BAE66] hover:text-[#EBD5AB] text-sm transition-colors">Documentation</a></li>
              <li><a href="#" className="text-[#8BAE66] hover:text-[#EBD5AB] text-sm transition-colors">Contact Support</a></li>
            </ul>
          </div>
        </div>
        
        <div className="mt-16 pt-8 border-t border-[#628141]/20 flex flex-col md:flex-row justify-between items-center gap-4">
          <p className="text-[#8BAE66]/60 text-xs">
            © 2026 EchoTrace Bukidnon. All rights reserved.
          </p>
          <div className="flex gap-6">
            <a href="#" className="text-[#8BAE66]/60 hover:text-[#EBD5AB] text-xs transition-colors">Privacy Policy</a>
            <a href="#" className="text-[#8BAE66]/60 hover:text-[#EBD5AB] text-xs transition-colors">Terms of Service</a>
          </div>
        </div>
      </div>
    </footer>
  );
}
