import { useState } from "react";
import { Search, MapPin, Tag, Activity, ArrowRight, CheckCircle2, PlusCircle } from "lucide-react";
import { Link } from "react-router";
import { ImageWithFallback } from "../components/figma/ImageWithFallback";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';
import { useRole } from "../context/RoleContext";

// Mock data for marketplace listings
const MOCK_LISTINGS = [
  {
    id: 1,
    title: "Mt. Kitanglad Buffer Zone Project",
    location: "Impasugong, Bukidnon",
    owner: "Datu Salise Family",
    price: 15.50,
    currency: "USD",
    creditsAvailable: 1200,
    absorptionRate: "1.2 tons CO2/day",
    verifiedBy: "DENR & EchoTrace IoT",
    image: "https://images.unsplash.com/photo-1564496027516-78e6fc218e97?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkcm9uZSUyMHNob3QlMjBmb3Jlc3QlMjBncmVlbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral",
    tags: ["Pine Forest", "Indigenous Owned"],
    sensorData: [
      { name: 'Mon', co2: 1.1 },
      { name: 'Tue', co2: 1.2 },
      { name: 'Wed', co2: 1.15 },
      { name: 'Thu', co2: 1.3 },
      { name: 'Fri', co2: 1.25 },
    ]
  },
  {
    id: 2,
    title: "Kalatungan Range Reforestation",
    location: "Pangantucan, Bukidnon",
    owner: "Talakag Farmers Coop",
    price: 18.00,
    currency: "USD",
    creditsAvailable: 850,
    absorptionRate: "0.9 tons CO2/day",
    verifiedBy: "EchoTrace IoT",
    image: "https://images.unsplash.com/photo-1684853693031-ab9e3f8c9d5e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhZXJpYWwlMjBmb3Jlc3QlMjBidWtpZG5vbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral",
    tags: ["Mahogany", "Community Coop"],
    sensorData: [
      { name: 'Mon', co2: 0.8 },
      { name: 'Tue', co2: 0.85 },
      { name: 'Wed', co2: 0.9 },
      { name: 'Thu', co2: 0.88 },
      { name: 'Fri', co2: 0.95 },
    ]
  },
  {
    id: 3,
    title: "Manolo Fortich Canopy Cover",
    location: "Manolo Fortich, Bukidnon",
    owner: "Araneta Estate",
    price: 14.20,
    currency: "USD",
    creditsAvailable: 3400,
    absorptionRate: "3.5 tons CO2/day",
    verifiedBy: "EchoTrace IoT & Local LGU",
    image: "https://images.unsplash.com/photo-1564496027516-78e6fc218e97?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkcm9uZSUyMHNob3QlMjBmb3Jlc3QlMjBncmVlbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral",
    tags: ["Mixed Dipterocarp", "Private"],
    sensorData: [
      { name: 'Mon', co2: 3.2 },
      { name: 'Tue', co2: 3.4 },
      { name: 'Wed', co2: 3.5 },
      { name: 'Thu', co2: 3.4 },
      { name: 'Fri', co2: 3.6 },
    ]
  }
];

export function Marketplace() {
  const [searchQuery, setSearchQuery] = useState("");
  const [activeTab, setActiveTab] = useState("all");
  const { role } = useRole();

  return (
    <div className="w-full min-h-screen bg-[#EBD5AB] text-[#1B211A]">
      <div className="bg-[#1B211A] pt-32 pb-20 border-b border-[#628141]/30">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h1 className="text-4xl md:text-5xl font-extrabold text-[#EBD5AB] tracking-tight mb-6">
            {role === "corporate" ? "Verified Carbon Credit Marketplace" : "Marketplace Demand & Competitors"}
          </h1>
          <p className="text-xl text-[#8BAE66] max-w-2xl mx-auto mb-10">
            {role === "corporate" 
              ? "Directly purchase scientifically-backed carbon offsets from Bukidnon landowners. Real data. Real impact."
              : "Discover active listings, monitor real-time pricing, and see how your projects perform against others."
            }
          </p>
          
          <div className="max-w-3xl mx-auto relative flex items-center">
            <Search className="absolute left-6 text-[#8BAE66] w-6 h-6" />
            <input 
              type="text" 
              placeholder="Search by location, owner, or project name..." 
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full bg-[#1B211A] border-2 border-[#628141] text-[#EBD5AB] rounded-full py-4 pl-16 pr-6 focus:outline-none focus:border-[#8BAE66] focus:ring-1 focus:ring-[#8BAE66] transition-all text-lg placeholder-[#8BAE66]/50"
            />
          </div>
          
          {role === "landowner" && (
            <div className="mt-8 flex justify-center">
              <button className="bg-[#628141] hover:bg-[#8BAE66] text-[#1B211A] px-6 py-3 rounded-full font-bold text-lg transition-colors flex items-center gap-2 shadow-lg shadow-[#628141]/20">
                <PlusCircle className="w-5 h-5" />
                List New Project
              </button>
            </div>
          )}
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="flex flex-col md:flex-row justify-between items-center mb-8">
          <div className="flex gap-2 bg-[#1B211A]/5 p-1 rounded-lg border border-[#628141]/20">
            {['All Projects', 'DENR Verified', 'Community Owned'].map((tab) => (
              <button
                key={tab}
                onClick={() => setActiveTab(tab.toLowerCase())}
                className={`px-4 py-2 rounded-md text-sm font-semibold transition-colors ${
                  activeTab === tab.toLowerCase() 
                    ? "bg-[#628141] text-[#EBD5AB] shadow-md shadow-[#628141]/20" 
                    : "text-[#1B211A]/70 hover:bg-[#628141]/10"
                }`}
              >
                {tab}
              </button>
            ))}
          </div>
          
          <div className="mt-4 md:mt-0 text-sm font-medium text-[#1B211A]/60 flex items-center gap-2">
            <Activity className="w-4 h-4 text-[#628141]" />
            Live data feed active
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {MOCK_LISTINGS.map((listing) => (
            <div key={listing.id} className="bg-white rounded-3xl overflow-hidden shadow-xl shadow-[#1B211A]/5 border border-[#628141]/10 flex flex-col hover:-translate-y-1 transition-transform duration-300">
              <div className="relative h-48 w-full">
                <ImageWithFallback 
                  src={listing.image}
                  alt={listing.title}
                  className="w-full h-full object-cover"
                />
                <div className="absolute top-4 right-4 bg-[#EBD5AB] text-[#1B211A] px-3 py-1 rounded-full text-xs font-bold flex items-center gap-1 shadow-lg shadow-black/20">
                  <CheckCircle2 className="w-3 h-3 text-[#628141]" />
                  Verified
                </div>
              </div>
              
              <div className="p-6 flex-1 flex flex-col">
                <div className="flex justify-between items-start mb-2">
                  <h3 className="font-bold text-xl text-[#1B211A] leading-tight pr-4">
                    {listing.title}
                  </h3>
                  <div className="text-right">
                    <span className="text-2xl font-extrabold text-[#628141]">
                      ${listing.price}
                    </span>
                    <span className="block text-[10px] uppercase tracking-wider text-[#1B211A]/50 font-bold">
                      per credit
                    </span>
                  </div>
                </div>
                
                <div className="flex items-center gap-1 text-[#1B211A]/70 text-sm mb-4 font-medium">
                  <MapPin className="w-4 h-4" />
                  {listing.location}
                </div>
                
                <div className="flex flex-wrap gap-2 mb-6">
                  {listing.tags.map(tag => (
                    <span key={tag} className="bg-[#628141]/10 text-[#628141] px-2 py-1 rounded text-xs font-bold flex items-center gap-1 border border-[#628141]/20">
                      <Tag className="w-3 h-3" />
                      {tag}
                    </span>
                  ))}
                </div>
                
                <div className="bg-[#EBD5AB]/30 rounded-xl p-4 mb-6 border border-[#628141]/10 relative overflow-hidden group">
                  <div className="text-xs font-bold text-[#1B211A]/50 uppercase tracking-wider mb-2 flex justify-between items-center z-10 relative">
                    <span>Live Sensor Data (CO2)</span>
                    <Activity className="w-3 h-3 text-[#628141] animate-pulse" />
                  </div>
                  <div className="h-16 w-full -ml-2 -mb-2 opacity-80 z-0">
                    <ResponsiveContainer width="100%" height="100%">
                      <LineChart data={listing.sensorData}>
                        <Line key="line" type="monotone" dataKey="co2" stroke="#628141" strokeWidth={2} dot={false} isAnimationActive={false} />
                      </LineChart>
                    </ResponsiveContainer>
                  </div>
                  <div className="absolute bottom-2 right-4 text-sm font-bold text-[#1B211A] z-10 bg-white/80 px-2 py-0.5 rounded backdrop-blur-sm border border-[#628141]/20">
                    {listing.absorptionRate}
                  </div>
                </div>
                
                <div className="mt-auto space-y-4">
                  <div className="flex justify-between items-center text-sm font-semibold">
                    <span className="text-[#1B211A]/60">Available Credits</span>
                    <span className="text-[#1B211A]">{listing.creditsAvailable.toLocaleString()}</span>
                  </div>
                  <div className="flex justify-between items-center text-sm font-semibold">
                    <span className="text-[#1B211A]/60">Owner</span>
                    <span className="text-[#1B211A]">{listing.owner}</span>
                  </div>
                  <Link 
                    to={`/project/${listing.id}`} 
                    className="w-full flex items-center justify-center gap-2 bg-[#1B211A] text-[#EBD5AB] py-3 rounded-xl font-bold hover:bg-[#628141] transition-colors mt-4 shadow-lg shadow-[#1B211A]/10 border border-[#1B211A]"
                  >
                    {role === "corporate" ? "View & Purchase" : "View Details"}
                    <ArrowRight className="w-4 h-4" />
                  </Link>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
