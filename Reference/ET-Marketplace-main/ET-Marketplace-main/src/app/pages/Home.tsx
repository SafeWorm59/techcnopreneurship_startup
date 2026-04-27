import { Link } from "react-router";
import { ArrowRight, Leaf, ShieldCheck, TreePine, Activity } from "lucide-react";
import { ImageWithFallback } from "../components/figma/ImageWithFallback";

export function Home() {
  return (
    <div className="w-full">
      {/* Hero Section */}
      <section className="relative overflow-hidden bg-[#1B211A] pt-32 pb-40">
        <div className="absolute inset-0 z-0 opacity-40 mix-blend-overlay">
          <ImageWithFallback 
            src="https://images.unsplash.com/photo-1684853693031-ab9e3f8c9d5e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxhZXJpYWwlMjBmb3Jlc3QlMjBidWtpZG5vbnxlbnwxfHx8fDE3NzUxMDA2MDF8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
            alt="Bukidnon Forest"
            className="w-full h-full object-cover"
          />
          <div className="absolute inset-0 bg-gradient-to-t from-[#1B211A] via-[#1B211A]/80 to-transparent" />
        </div>

        <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-[#628141]/20 border border-[#8BAE66]/30 backdrop-blur-sm mb-8">
            <span className="flex h-2 w-2 rounded-full bg-[#8BAE66] animate-pulse"></span>
            <span className="text-sm font-medium text-[#EBD5AB] tracking-wide">Live Carbon Verification in Bukidnon</span>
          </div>
          
          <h1 className="text-5xl md:text-7xl font-extrabold text-[#EBD5AB] tracking-tight mb-8 leading-tight">
            Turn Standing Trees Into <br className="hidden md:block" />
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-[#8BAE66] to-[#628141]">
              Verifiable Green Capital.
            </span>
          </h1>
          
          <p className="mt-6 max-w-2xl mx-auto text-xl text-[#8BAE66] leading-relaxed">
            Free sensors for landowners. Real-time proof for corporate buyers. 
            Keep trees standing. Get paid.
          </p>
          
          <div className="mt-12 flex flex-col sm:flex-row justify-center gap-4">
            <Link
              to="/marketplace"
              className="inline-flex items-center justify-center px-8 py-4 text-base font-bold rounded-full text-[#1B211A] bg-[#EBD5AB] hover:bg-white transition-all transform hover:scale-105 shadow-xl shadow-[#EBD5AB]/10"
            >
              Explore Verified Credits
              <ArrowRight className="ml-2 w-5 h-5" />
            </Link>
            <Link
              to="/dashboard"
              className="inline-flex items-center justify-center px-8 py-4 text-base font-bold rounded-full text-[#EBD5AB] bg-[#628141] hover:bg-[#8BAE66] transition-all border border-[#8BAE66]/50 shadow-xl shadow-[#628141]/20"
            >
              I am a Landowner
            </Link>
          </div>
        </div>
      </section>

      {/* Value Props */}
      <section className="py-24 bg-[#EBD5AB]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold text-[#1B211A] tracking-tight">
              Bridging the gap between <br className="md:hidden" />
              Bukidnon and Global Net-Zero
            </h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-12">
            {[
              {
                icon: <Activity className="w-8 h-8 text-[#EBD5AB]" />,
                title: "EchoTrace IoT Sensors",
                description: "Automated tracking of CO2 absorption replaces manual logs. We install sensors for free; you pay only when credits are sold."
              },
              {
                icon: <ShieldCheck className="w-8 h-8 text-[#EBD5AB]" />,
                title: "Verified Legitimacy",
                description: "Sensor validation provides the objective proof that global buyers demand. Say goodbye to opaque carbon offsets."
              },
              {
                icon: <TreePine className="w-8 h-8 text-[#EBD5AB]" />,
                title: "Earn Without Cutting",
                description: "Trees now have cash value while standing. Landowners gain profit, avoiding the pressure to cut for agriculture."
              }
            ].map((feature, idx) => (
              <div key={idx} className="bg-[#1B211A] p-8 rounded-3xl shadow-xl hover:shadow-2xl transition-shadow border border-[#628141]/20 group">
                <div className="w-16 h-16 rounded-2xl bg-[#628141] flex items-center justify-center mb-6 group-hover:scale-110 group-hover:bg-[#8BAE66] transition-all">
                  {feature.icon}
                </div>
                <h3 className="text-xl font-bold text-[#EBD5AB] mb-4">{feature.title}</h3>
                <p className="text-[#8BAE66] leading-relaxed">{feature.description}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* For Buyers Section */}
      <section className="py-24 bg-[#1B211A] text-[#EBD5AB] border-y border-[#628141]/30">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
            <div className="relative h-[500px] rounded-3xl overflow-hidden shadow-2xl shadow-[#628141]/20 border border-[#628141]/30">
              <ImageWithFallback 
                src="https://images.unsplash.com/photo-1763380265398-ded34d778f79?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxsdXNoJTIwZm9yZXN0JTIwdHJlZXN8ZW58MXx8fHwxNzc1MDkwNzIxfDA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
                alt="Bukidnon Forest Trees"
                className="w-full h-full object-cover"
              />
              <div className="absolute inset-0 bg-[#1B211A]/40 mix-blend-multiply" />
            </div>
            
            <div className="space-y-8">
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#628141]/20 border border-[#8BAE66]/30 text-[#8BAE66] text-sm font-semibold">
                For Corporate Buyers
              </div>
              <h2 className="text-4xl md:text-5xl font-bold tracking-tight">
                Trust the data. <br/>
                <span className="text-[#8BAE66]">Hit your Net-Zero targets.</span>
              </h2>
              <p className="text-xl text-[#8BAE66]/80 leading-relaxed">
                Global buyers have bypassed Bukidnon because of unverified data. EchoTrace solves this by combining live sensor tracking with local NGO validation.
              </p>
              
              <ul className="space-y-4">
                {['Live sensor tracking & reports', 'Transparent pricing', 'Digital contracts handled on-platform'].map((item, i) => (
                  <li key={i} className="flex items-center gap-3">
                    <div className="flex-shrink-0 w-6 h-6 rounded-full bg-[#628141] flex items-center justify-center">
                      <ShieldCheck className="w-4 h-4 text-[#EBD5AB]" />
                    </div>
                    <span className="text-lg text-[#EBD5AB]/90">{item}</span>
                  </li>
                ))}
              </ul>
              
              <Link
                to="/marketplace"
                className="inline-flex items-center gap-2 text-[#8BAE66] font-bold text-lg hover:text-[#EBD5AB] transition-colors mt-4 group"
              >
                Go to Marketplace
                <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
              </Link>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
