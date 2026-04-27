import { useParams, Link } from "react-router";
import { MapPin, ShieldCheck, TreePine, Activity, Tag, ArrowLeft, CheckCircle2, DollarSign, Settings } from "lucide-react";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';
import { ImageWithFallback } from "../components/figma/ImageWithFallback";
import { useRole } from "../context/RoleContext";

// Reusing mock data for simplicity
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
    verifiedBy: "BENRO & EchoTrace IoT",
    image: "https://images.unsplash.com/photo-1564496027516-78e6fc218e97?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxkcm9uZSUyMHNob3QlMjBmb3Jlc3QlMjBncmVlbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral",
    tags: ["Pine Forest", "Indigenous Owned"],
    description: "This project protects a vital buffer zone in the Mt. Kitanglad range, preventing agricultural encroachment. The standing trees act as a massive carbon sink, continuously monitored by EchoTrace sensors.",
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
    description: "A community-led initiative focused on reforestation. By purchasing these credits, you directly support the livelihood of the Talakag Farmers Cooperative while verifiable offsetting your carbon footprint.",
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
    description: "A large-scale private estate that has committed to maintaining its massive canopy cover. Equipped with extensive EchoTrace IoT sensors for granular carbon absorption data.",
    sensorData: [
      { name: 'Mon', co2: 3.2 },
      { name: 'Tue', co2: 3.4 },
      { name: 'Wed', co2: 3.5 },
      { name: 'Thu', co2: 3.4 },
      { name: 'Fri', co2: 3.6 },
    ]
  }
];

export function ProjectDetails() {
  const { id } = useParams();
  const { role } = useRole();
  const project = MOCK_LISTINGS.find(p => p.id === Number(id)) || MOCK_LISTINGS[0];

  return (
    <div className="w-full min-h-screen bg-[#EBD5AB] text-[#1B211A] pb-24">
      <div className="bg-[#1B211A] pt-8 pb-32 border-b border-[#628141]/30">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <Link to="/marketplace" className="inline-flex items-center gap-2 text-[#8BAE66] hover:text-[#EBD5AB] transition-colors mb-8 font-semibold">
            <ArrowLeft className="w-4 h-4" />
            Back to Marketplace
          </Link>
          <div className="flex flex-col md:flex-row gap-8 items-start">
            <div className="flex-1">
              <div className="flex flex-wrap gap-2 mb-4">
                {project.tags.map(tag => (
                  <span key={tag} className="bg-[#628141]/20 text-[#8BAE66] px-3 py-1 rounded-full text-xs font-bold border border-[#628141]/30">
                    {tag}
                  </span>
                ))}
              </div>
              <h1 className="text-4xl md:text-5xl font-extrabold text-[#EBD5AB] tracking-tight mb-4 leading-tight">
                {project.title}
              </h1>
              <div className="flex items-center gap-2 text-[#8BAE66] text-lg mb-6 font-medium">
                <MapPin className="w-5 h-5" />
                {project.location}
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 -mt-24">
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <div className="lg:col-span-2 space-y-8">
            <div className="bg-white rounded-3xl overflow-hidden shadow-2xl shadow-[#1B211A]/10 border border-[#628141]/20 h-[400px]">
              <ImageWithFallback 
                src={project.image}
                alt={project.title}
                className="w-full h-full object-cover"
              />
            </div>
            
            <div className="bg-white rounded-3xl p-8 shadow-xl shadow-[#1B211A]/5 border border-[#628141]/10">
              <h2 className="text-2xl font-bold mb-4">About the Project</h2>
              <p className="text-[#1B211A]/80 leading-relaxed text-lg mb-8">
                {project.description}
              </p>
              
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                <div className="bg-[#EBD5AB]/30 p-6 rounded-2xl border border-[#628141]/10">
                  <div className="flex items-center gap-3 mb-2">
                    <TreePine className="w-6 h-6 text-[#628141]" />
                    <h3 className="font-bold">Landowner</h3>
                  </div>
                  <p className="text-lg font-semibold">{project.owner}</p>
                </div>
                <div className="bg-[#EBD5AB]/30 p-6 rounded-2xl border border-[#628141]/10">
                  <div className="flex items-center gap-3 mb-2">
                    <ShieldCheck className="w-6 h-6 text-[#628141]" />
                    <h3 className="font-bold">Verification</h3>
                  </div>
                  <p className="text-lg font-semibold">{project.verifiedBy}</p>
                </div>
              </div>
            </div>

            <div className="bg-white rounded-3xl p-8 shadow-xl shadow-[#1B211A]/5 border border-[#628141]/10">
              <div className="flex justify-between items-center mb-6">
                <h2 className="text-2xl font-bold flex items-center gap-2">
                  <Activity className="w-6 h-6 text-[#628141]" />
                  Live Sensor Data
                </h2>
                <div className="bg-[#628141]/10 text-[#628141] px-3 py-1 rounded-full text-sm font-bold flex items-center gap-2">
                  <span className="w-2 h-2 rounded-full bg-[#628141] animate-pulse"></span>
                  Online
                </div>
              </div>
              <div className="h-72 w-full">
                <ResponsiveContainer width="100%" height="100%">
                  <LineChart data={project.sensorData}>
                    <CartesianGrid key="grid" strokeDasharray="3 3" vertical={false} stroke="#EBD5AB" />
                    <XAxis key="xaxis" dataKey="name" axisLine={false} tickLine={false} tick={{ fill: '#1B211A', opacity: 0.5, fontWeight: 'bold' }} />
                    <YAxis key="yaxis" axisLine={false} tickLine={false} tick={{ fill: '#1B211A', opacity: 0.5, fontWeight: 'bold' }} />
                    <Tooltip 
                      key="tooltip"
                      contentStyle={{ backgroundColor: '#1B211A', borderRadius: '12px', border: 'none', color: '#EBD5AB', fontWeight: 'bold' }}
                      itemStyle={{ color: '#8BAE66' }}
                    />
                    <Line key="line" type="monotone" dataKey="co2" stroke="#628141" strokeWidth={3} dot={{ fill: '#628141', strokeWidth: 2, r: 4 }} activeDot={{ r: 8 }} />
                  </LineChart>
                </ResponsiveContainer>
              </div>
              <div className="mt-4 text-center">
                <p className="text-[#1B211A]/60 font-medium">Average Absorption Rate</p>
                <p className="text-2xl font-extrabold text-[#628141]">{project.absorptionRate}</p>
              </div>
            </div>
          </div>

          <div className="lg:col-span-1">
            <div className="bg-[#1B211A] rounded-3xl p-8 shadow-2xl border border-[#628141]/30 sticky top-28">
              <div className="mb-6 pb-6 border-b border-[#628141]/30">
                <div className="flex justify-between items-end mb-2">
                  <span className="text-[#8BAE66] font-medium">Price per credit</span>
                  <div className="text-right">
                    <span className="text-4xl font-extrabold text-[#EBD5AB]">${project.price}</span>
                    <span className="text-[#8BAE66] font-bold ml-1">{project.currency}</span>
                  </div>
                </div>
                <div className="flex justify-between items-center text-sm">
                  <span className="text-[#8BAE66]/80">Available Credits</span>
                  <span className="text-[#EBD5AB] font-bold bg-[#628141]/20 px-2 py-1 rounded">{project.creditsAvailable.toLocaleString()}</span>
                </div>
              </div>

              <div className="space-y-4 mb-8">
                <div className="flex items-center gap-3 text-[#EBD5AB]">
                  <CheckCircle2 className="w-5 h-5 text-[#628141]" />
                  <span className="font-medium">Verified by EchoTrace IoT</span>
                </div>
                <div className="flex items-center gap-3 text-[#EBD5AB]">
                  <CheckCircle2 className="w-5 h-5 text-[#628141]" />
                  <span className="font-medium">Direct payment to landowner</span>
                </div>
                <div className="flex items-center gap-3 text-[#EBD5AB]">
                  <CheckCircle2 className="w-5 h-5 text-[#628141]" />
                  <span className="font-medium">Instant certificate generation</span>
                </div>
              </div>

              <div className="space-y-4">
                {role === "corporate" ? (
                  <button className="w-full bg-[#EBD5AB] text-[#1B211A] py-4 rounded-xl font-extrabold text-lg hover:bg-white transition-colors flex items-center justify-center gap-2 shadow-lg shadow-[#EBD5AB]/10">
                    <DollarSign className="w-5 h-5" />
                    Purchase Credits
                  </button>
                ) : (
                  <button className="w-full bg-[#8BAE66] text-[#1B211A] py-4 rounded-xl font-extrabold text-lg hover:bg-[#EBD5AB] transition-colors flex items-center justify-center gap-2 shadow-lg shadow-[#8BAE66]/10">
                    <Settings className="w-5 h-5" />
                    Manage Listing
                  </button>
                )}
                <button className="w-full bg-transparent text-[#8BAE66] py-4 rounded-xl font-bold border-2 border-[#628141]/50 hover:bg-[#628141]/10 transition-colors">
                  Download Project Report
                </button>
              </div>
              
              <p className="text-center text-[#8BAE66]/60 text-xs mt-6">
                Transactions are secured by EchoTrace network.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}